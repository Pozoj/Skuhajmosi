class RenameSourcesToOrigins < ActiveRecord::Migration
  def self.up
    rename_table :sources, :origins
  end

  def self.down
    rename_table :origins, :sources
  end
end
