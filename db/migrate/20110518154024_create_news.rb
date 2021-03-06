class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :title
      t.date :date
      t.text :text
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
