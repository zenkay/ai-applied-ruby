require "faraday"
require "faraday_middleware"
require "json"

module Applied

  class Sentiment

    ENDPOINT = "/api/sentiment_api/"
    PERMITTED_OPTIONS = [:return_original, :classifier]
    CLASSIFIERS = ["default", "subjective"]
    AVAILABLE_LANGUAGES = ["eng", "nld", "deu", "fra", "spa", "ita", "rus"]

    attr_accessor :return_original, :classifier

    def analyze(data, options = {})

      # checks on data

      raise Applied::BadData unless data.instance_of? Array

      data.each do |d|
        raise Applied::BadData if d[:text].nil? or d[:text].empty?
        raise Applied::BadData unless [Fixnum, String].include? d[:id].class
        raise Applied::BadData if d[:language_iso].nil? or d[:language_iso].empty? or not AVAILABLE_LANGUAGES.include? d[:language_iso]
      end

      # checks on options

      unless options[:return_original].nil?
        raise Applied::BadOptions unless [true, false].include? options[:return_original]
      else
        options[:return_original] = false
      end 

      unless options[:classifier].nil?
        raise Applied::BadOptions unless CLASSIFIERS.include? options[:classifier]
      else
        options[:classifier] = "default"
      end

      # options cleanup

      options.delete_if {|o| not PERMITTED_OPTIONS.include? o}

      call(ENDPOINT, data, options)
    end

    protected

    def call(endpoint, data, options)
      begin
        request = {
          data: {
            api_key: Applied.config.api_key,
            call: {
               return_original: options[:return_original],
               classifier: options[:classifier],
               data: data
            }
          }
        }
        conn = Faraday.new(url: Applied.config.endpoint) do |faraday|
          faraday.request  :url_encoded
          faraday.adapter  Faraday.default_adapter
        end
        response = conn.post endpoint, request: request.to_json
        JSON.parse response.body
      rescue Exception => e
        raise Applied::BadResponse
      end
    end


  end

  class BadOptions < Exception; end

  class BadData < Exception; end


end