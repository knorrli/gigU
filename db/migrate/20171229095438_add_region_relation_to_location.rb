class AddRegionRelationToLocation < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :region
    add_column :locations, :region_id, :integer

    remove_column :locations, :city
    add_column :locations, :city_id, :integer
  end
end
