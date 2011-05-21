class RenameParticipantToParticipation < ActiveRecord::Migration
  def self.up
    rename_table :participants, :participations
  end

  def self.down
    rename_table :participations, :participants
  end
end

