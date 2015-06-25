require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json',
    query_values: {
    }
  ).to_s

  puts RestClient.post(url,
    { user: { name: "Johnny", email: "jblaze@f4.com" } }
  )
rescue RestClient::Exception => e
  puts "There was an error: " + e.message
end

create_user
