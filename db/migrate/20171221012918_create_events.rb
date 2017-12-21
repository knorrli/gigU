class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.date :date
      t.string :name

      t.belongs_to :location
      t.timestamps
    end
  end
end
