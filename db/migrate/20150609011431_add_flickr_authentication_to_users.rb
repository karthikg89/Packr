class AddFlickrAuthenticationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :flickr_auth, :boolean, default: false
    add_column :users, :flickr_token, :string
    add_column :users, :flickr_token_secret, :string
  end
end
