class AddPolicesToRole < ActiveRecord::Migration
  def change
    add_column :roles, :policies, :json
  end
end
