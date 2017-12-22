class AddDescriptionAndLinkToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :description, :string
    add_column :events, :link, :string
  end
end
