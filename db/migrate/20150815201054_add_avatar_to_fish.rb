class AddAvatarToFish < ActiveRecord::Migration
  def self.up
    add_attachment :fish, :avatar
  end

  def self.down
    remove_attachment :fish, :avatar
  end
end

