class RenameUserIdToProfileId < ActiveRecord::Migration[5.1]
  def change
    rename_column :location_interests, :user_id, :profile_id
  end
end
