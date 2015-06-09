class AddFlickrAuthTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :flickr_auth_at, :datetime
  end
end
