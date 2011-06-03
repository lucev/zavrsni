class AddTypeToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :type, :string
  end

  def self.down
    remove_column :searches, :type
  end
end

