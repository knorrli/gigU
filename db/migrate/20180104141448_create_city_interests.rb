class CreateCityInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :city_interests do |t|
      t.belongs_to :profile
      t.belongs_to :city
      t.timestamps
    end
  end
end
