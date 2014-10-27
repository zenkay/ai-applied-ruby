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
  
  it "initialize a new sentiment request" do
    request = Applied::Sentiment.new
    expect(request).to be_an_instance_of(Applied::Sentiment)
  end

  it "make a request sentiment of an italian sentence" do
    element = Applied::Sentiment.new
    options = {return_original: false, classifier: "default"}
    data = [{text: "Sono molto contento di quello che è successo", language_iso: "ita", id: 42}]
    response = element.analyze(data, options)
    expect(response).not_to be_empty
    expect(response["status"]).to eq 1
    expect(response["response"]).to be_a Hash
    expect(response["response"]["data"]).to be_a Array
    response["response"]["data"].each do |d|
      expect(d["sentiment_class"]).to match /positive|negative|unknown/
      expect(d["id"]).to be 42
      expect(d["confidence_sentiment"]).to be_between(0.0, 1.0)
    end
  end

  it "make multiple request sentiment of an italian sentence" do
    element = Applied::Sentiment.new
    options = {return_original: false, classifier: "default"}
    data = [
      {text: "Sono molto contento di quello che è successo", language_iso: "ita", id: 42},
      {text: "Sono molto arrabbiato per quello che è successo", language_iso: "ita", id: 69},
      {text: "Sono molto indifferente a quello che è successo", language_iso: "ita", id: 99}
    ]
    response = element.analyze(data, options)
    expect(response).not_to be_empty
    expect(response["status"]).to eq 1
    expect(response["response"]).to be_a Hash
    expect(response["response"]["data"]).to be_a Array
    response["response"]["data"].each do |d|
      expect(d["sentiment_class"]).to match /positive|negative|unknown/
      expect(d["id"]).to be 42
      expect(d["confidence_sentiment"]).to be_between(0.0, 1.0)
    end
  end

  it "make a request sentiment of an italian sentence using default options" do
    element = Applied::Sentiment.new
    data = [{text: "Sono molto contento di quello che è successo", language_iso: "ita", id: 42}]
    response = element.analyze(data)
    expect(response).not_to be_empty
    expect(response["status"]).to eq 1
    expect(response["response"]).to be_a Hash
    expect(response["response"]["data"]).to be_a Array
    response["response"]["data"].each do |d|
      expect(d["sentiment_class"]).to match /positive|negative|unknown/
      expect(d["id"]).to be 42
      expect(d["confidence_sentiment"]).to be_between(0.0, 1.0)
    end
  end

  it "raise BadData on missing text" do
    element = Applied::Sentiment.new
    expect { element.analyze([{language_iso: "ita", id: 42}]) }.to raise_error(Applied::BadData)
  end

  it "raise BadData on missing language" do
    element = Applied::Sentiment.new
    expect { element.analyze([{text: "test", id: 42}]) }.to raise_error(Applied::BadData)
  end

  it "raise BadData on missing text" do
    element = Applied::Sentiment.new
    expect { element.analyze([{text: "test", language_iso: "ita"}]) }.to raise_error(Applied::BadData)
  end

  it "raise BadOptions on wrong return_original" do
    element = Applied::Sentiment.new
    expect { element.analyze([{text: "test", language_iso: "ita", id: 42}], {return_original: "maybe"}) }.to raise_error(Applied::BadOptions)
  end

  it "raise BadOptions on wrong classifier" do
    element = Applied::Sentiment.new
    expect { element.analyze([{text: "test", language_iso: "ita", id: 42}], {classifier: "cool"}) }.to raise_error(Applied::BadOptions)
  end

  it "raise BadResponse on wrong config parameters" do
    Applied.configure do |c|
      c.api_key = "bad-app-id"
      c.endpoint = "not-an-url-endpoint"
    end
    element = Applied::Sentiment.new
    expect { element.analyze([{text: "test", language_iso: "ita", id: 42}]) }.to raise_error(Applied::BadResponse)
  end

end