class RenameLinkToUrl < ActiveRecord::Migration[5.1]
  def change
    rename_column :locations, :link, :events_url
    rename_column :events, :link, :url
  end
end
