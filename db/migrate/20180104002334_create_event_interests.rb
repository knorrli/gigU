class CreateEventInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :event_interests do |t|
      t.belongs_to :profile
      t.belongs_to :event
      t.timestamps
    end
  end
end
