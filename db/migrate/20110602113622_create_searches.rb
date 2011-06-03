class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.datetime :start_date
      t.datetime :end_date
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
