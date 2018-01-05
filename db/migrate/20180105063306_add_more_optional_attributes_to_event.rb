class AddMoreOptionalAttributesToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :subtitle, :string
    add_column :events, :starts_at, :datetime
    add_column :events, :ends_at, :datetime
    add_column :events, :admission, :string
    add_column :events, :extras, :text
    add_column :events, :doors, :datetime
  end
end
