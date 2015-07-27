class AddSlugToFish < ActiveRecord::Migration
  def change
    add_column :fish, :slug, :string
    add_index  :fish, :slug
  end
end
