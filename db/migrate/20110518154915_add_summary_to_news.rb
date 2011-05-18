class AddSummaryToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :summary, :text
  end

  def self.down
    remove_column :news, :summary
  end
end

