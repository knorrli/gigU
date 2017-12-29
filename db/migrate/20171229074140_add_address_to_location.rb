class AddAddressToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :street, :string
    add_column :locations, :zip, :string
    add_column :locations, :city, :string
    add_column :locations, :region, :string
  end
end
