class ChangeColumnType < ActiveRecord::Migration
  def self.up
    change_table :events do |e|
      e.change :start_date, :datetime
      e.change :end_date, :datetime
    end
  end

  def self.down
    change_table :events do |e|
      e.change :start_date, :date
      e.change :end_date, :date
    end
  end
end

