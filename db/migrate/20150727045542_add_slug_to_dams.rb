class AddSlugToDams < ActiveRecord::Migration
  def change
    add_column :dams, :slug, :string
    add_index  :dams, :slug
  end
end
