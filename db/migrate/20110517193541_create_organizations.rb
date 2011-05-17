class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.date :date_of_establishment
      t.string :email
      t.text :informations

      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
