require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      raw_params = req.query_string.to_s.concat(req.body.to_s)
      query_params = parse_www_encoded_form(raw_params)
      @params = [query_params, route_params].inject(&:merge)
    end

    def [](key)
      if key.is_a?(String)
        @params[key]
      else
        @params[key.to_s]
      end
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
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

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
