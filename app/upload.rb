require 'flickraw'

FlickRaw.api_key=ENV['FLICKR_API_KEY']
FlickRaw.shared_secret=ENV['FLICKR_SHARED_SECRET']

#permissions: "delete"

list = flickr.photos.getRecent

id     = list[0].id
secret = list[0].secret
info = flickr.photos.getInfo :photo_id => id, :secret => secret

puts info.title           # => "PICT986"
puts info.dates.taken     # => "2006-07-06 15:16:18"

sizes = flickr.photos.getSizes :photo_id => id

original = sizes.find {|s| s.label == 'Original' }
puts original.width



=begin
token = flickr.get_request_token
auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

puts "Open this url in your process to complete the authication process : #{auth_url}"
puts "Copy here the number given when you complete the process."
verify = gets.strip

begin
  flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
  login = flickr.test.login
  puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
rescue FlickRaw::FailedResponse => e
  puts "Authentication failed : #{e.msg}"
end
=end
=begin
PHOTO_PATH = 'railsBook.pdf.pac/railsBook.pdf.1.png'

flickr.access_token = "72157649087693152-b8f1f8a194f7637b"
flickr.access_secret = "5f1e8d196780edf0"

flickr.upload_photo PHOTO_PATH, :title=> ARGV[0], :description => ARGV[1]
puts "CAlled"
=end
