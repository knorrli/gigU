class RenameEventNameToTitle < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :name, :title
  end
end
