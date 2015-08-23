class AddCodeToDam < ActiveRecord::Migration
def change
    add_column :dams, :code, :string
  end
end
