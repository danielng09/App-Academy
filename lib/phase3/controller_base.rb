require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'
require 'byebug'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    include ActiveSupport
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      full_path = "views/" + "#{self.class}".underscore + "/#{template_name}" + ".html.erb"
      log = File.read(full_path)
      contents = ERB.new(log).result(binding)
      render_content(contents, "text/html")
    end
  end
end
