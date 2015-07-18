class CreateFishCounts < ActiveRecord::Migration
  def change
    create_table :fish_counts do |t|
      t.integer :dam_id
      t.integer :fish_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
