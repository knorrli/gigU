class CreateRegionInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :region_interests do |t|
      t.belongs_to :profile
      t.belongs_to :region

      t.timestamps
    end
  end
end
