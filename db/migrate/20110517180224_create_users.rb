class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.date :birthday
      t.string :phone
      t.string :genre
      t.string :profession
      t.text :interests

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
