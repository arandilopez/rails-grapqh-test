class Employee < ApplicationRecord
  belongs_to :role
  belongs_to :department
  has_many :contact_informations
end
