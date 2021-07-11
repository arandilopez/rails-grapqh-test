class CreateContactInformations < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_informations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.belongs_to :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
