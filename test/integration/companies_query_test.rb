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

    # Expect 4 queries, one for each related model: Company, Department, Employee, Role
    assert_equal recorder.count, 4
  end
end
