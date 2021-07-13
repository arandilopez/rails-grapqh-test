require "test_helper"
require 'support/helpers/query_recorder'

class CompaniesQueryTest < ActionDispatch::IntegrationTest
  setup do
    Rails.application.load_seed
  end

  test 'number of queries performed on db are exactly 4' do
    query = <<-GRAPHQL
      {
        companies {
          nodes {
            id
            name
            departments {
              nodes {
                id
                name
                employees {
                  nodes {
                    id
                    name
                    email
                    role {
                      name
                    }
                  }
                }
              }
            }
          }
        }
      }
    GRAPHQL

    recorder = ActiveRecord::QueryRecorder.new(skip_cached: false) do
      post graphql_url, params: { query: query }
    end

    # Expect 4 queries, one for each related model: Company -> Department -> Employee -> Role
    assert_equal 4, recorder.count
  end

  # This is a more complex query as Roles are not directly related to Companies.
  # To fetch the roles by company I perform a complex query that joins employees, departemnts and company
  # to filter the roles by company.
  # Same with employees, If we fetch employees from roles without filtering the roles on the company
  # we cannot get que subset of related employees to the role on the respective company.
  # BatchLoader supports doing these complex queries too.
  test 'number of queries performed on db are exactly 4 for a complex nested query' do
    query = <<-GRAPHQL
    {
      companies {
        nodes {
          id
          name
          roles {
            nodes {
              name
              employees {
                nodes {
                  name
                  email
                  department {
                    name
                  }
                }
              }
            }
          }
        }
      }
    }
    GRAPHQL

    recorder = ActiveRecord::QueryRecorder.new(skip_cached: false) do
      post graphql_url, params: { query: query }
    end

    # Expect 4 queries, one for each related model: Company -> Role -> Employee -> Department
    assert_equal 4, recorder.count
  end
end
