class FlickrAuthsController < ApplicationController
  def edit
    user = User.find(params[:id])
    @callback_url = edit_flickr_auth_path(user)
    flickr = FlickRaw::Flickr.new
    token = flickr.get_request_token(oauth_callback: URI.escape(@callback_url))
  end
end
