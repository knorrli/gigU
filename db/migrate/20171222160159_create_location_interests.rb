class CreateLocationInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :location_interests do |t|
      t.belongs_to :user
      t.belongs_to :location

      t.timestamps
    end
  end
end
