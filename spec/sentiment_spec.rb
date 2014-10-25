require 'spec_helper'

vcr_options = { :cassette_name => "applied_sentiment", :record => :new_episodes }

describe Applied::Sentiment, vcr: vcr_options do

  before(:each) do
    Applied.configure do |c|
      # account: <applied@mailinator.com>
      c.api_key = "837b4a6bc73bce85abec5db64dfcde9cab92a1bf"
      c.endpoint = "http://api.ai-applied.nl/"
    end
  end
  
  it "initialize a new sim request" do
    request = Applied::Sentiment.new
    expect(request).to be_an_instance_of(Applied::Sentiment)
  end

  it "make a request to sim using two italian plain texts" do
    element = Applied::Sentiment.new
    options = {return_original: false, classifier: "default"}
    data = [{text: "Ma che figata", language_iso: "ita", id: 0}]
    response = element.analyze(data, options)

puts response.inspect

    expect(response).not_to be_empty
    expect(response["status"]).to eq 1
    expect(response["response"]).to be_a Hash
    expect(response["response"]["data"]).to be_a Array
    response["response"]["data"].each do |d|
      expect(d["sentiment_class"]).not_to be_empty
      expect(d["id"]).not_to be_empty
      expect(d["confidence_sentiment"]).not_to be_empty
    end
  end

  # it "raise exception on wrong config parameters" do
  #   Datatxt.configure do |c|
  #     c.app_id = "bad-app-id"
  #     c.app_key = "bad-app-key"
  #     c.endpoint = "not-an-url-endpoint"
  #   end
  #   element = Datatxt::Sim.new
  #   expect { element.analyze(text: "test") }.to raise_error(Datatxt::BadResponse)
  # end

end