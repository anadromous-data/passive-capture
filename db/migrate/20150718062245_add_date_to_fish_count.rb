class AddDateToFishCount < ActiveRecord::Migration
def change
    add_column :fish_counts, :count_date, :date
  end
end