require 'params'
require 'session'
require 'router'
require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'

class ControllerBase
  attr_reader :params,:req, :res

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @already_built_response = false
    @params = Params.new(req, route_params)
  end

  def invoke_action(name)
    self.send(name)
    self.render(name) unless already_built_response?
  end

  def session
    @session ||= Session.new(@req)
  end

  def render(template_name)
    full_path = "views/" + "#{self.class}".underscore + "/#{template_name}" + ".html.erb"
    log = File.read(full_path)
    contents = ERB.new(log).result(binding)
    render_content(contents, "text/html")
  end

  def already_built_response?
    @already_built_response
  end

  def redirect_to(url)
    raise "Already built" if already_built_response?
    @already_built_response = true
    @res["location"] = url
    @res.status = 302
    session.store_session(@res)
  end

  def render_content(content, content_type)
    raise "Already built" if already_built_response?
    @already_built_response = true
    @res.body = content
    @res.content_type = content_type
    session.store_session(@res)
  end
end
