require 'webrick'

server = WEBrick::HTTPServer.new(:Port => 3000)

server.mount_proc("/") do |request, response|
  response.body = "#{request.unparsed_uri}"
end

trap('INT') do
  server.shutdown
end

server.start
