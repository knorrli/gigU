class AddLinkToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :link, :string
  end
end
