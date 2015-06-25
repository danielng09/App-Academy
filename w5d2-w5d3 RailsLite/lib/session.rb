require 'json'
require 'webrick'

class Session
  def initialize(req)
    cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_app" }
    if cookie
      @content = JSON.parse(cookie.value)
    else
      @content = Hash.new
    end
  end

  def [](key)
    @content[key]
  end

  def []=(key, val)
    @content[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new("_rails_lite_app", @content.to_json)
  end
end
