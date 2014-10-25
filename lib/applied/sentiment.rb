require "faraday"
require "faraday_middleware"
require "json"

module Applied

  class Sentiment

    ENDPOINT = "/api/sentiment_api/"

    attr_accessor :return_original, :classifier

    def analyze(data, options)
      params = options
      call(ENDPOINT, data, options)
    end

    protected

    def call(endpoint, data, options)
      request = {
        data: {
          api_key: Applied.config.api_key,
          call: {
             return_original: options[:return_original],
             classifier: options[:classifier],
             data:[data]
          }
        }
      }
      begin
        conn = Faraday.new(url: Applied.config.endpoint) do |faraday|
          faraday.request  :url_encoded
          faraday.adapter  Faraday.default_adapter
        end
        response = conn.post endpoint, request: request.to_json
        JSON.parse response.body
      rescue Exception => e
        raise Datatxt::BadResponse
      end
    end


  end

end