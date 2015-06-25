require 'uri'

class Params

  def initialize(req, route_params = {})
    raw_params = req.query_string.to_s.concat(req.body.to_s)
    query_params = parse_www_encoded_form(raw_params)
    @params = [query_params, route_params].inject(&:merge)
  end

  def [](key)
    @params[key.to_s]
  end

  def to_s
    @params.to_json.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private

  def parse_www_encoded_form(www_encoded_form)
    data = www_encoded_form.split("&").map { |combo| combo.split("=") }
    data.map! { |combo| [parse_key(combo.first), combo.last] }
    build_params(data)
  end

  def build_params(data)
    params = {}
    data.each do |pair|
      keys = pair.first
      value = pair.last
      current = params
      keys.each_with_index do |key, index|
        if index == keys.length - 1
          current[key] = value
        else
          current[key] ||= {}
          current = current[key]
        end
      end
    end
    params
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
