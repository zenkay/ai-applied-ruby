# [![Ruby Gem Icon](https://raw.githubusercontent.com/zenkay/ai-applied-ruby/master/rubygem.png)](https://rubygems.org/gems/applied) AI Applied Ruby Gem

[![Code Climate](https://codeclimate.com/github/zenkay/ai-applied-ruby/badges/gpa.svg)](https://codeclimate.com/github/zenkay/ai-applied-ruby) [![Travis CI](https://travis-ci.org/zenkay/ai-applied-ruby.svg?branch=master)](https://travis-ci.org/zenkay/applied-ruby) [![Gem Version](https://badge.fury.io/rb/applied.svg)](http://badge.fury.io/rb/applied) [![Coverage Status](https://coveralls.io/repos/zenkay/ai-applied-ruby/badge.png?branch=master)](https://coveralls.io/r/zenkay/ai-applied-ruby?branch=master)

## Installation

Add this line to your application's Gemfile:

```
gem 'applied'
```

And then execute:

```
$ bundle install
```
## Setup

Setup configuration parameters

```
Applied.configure do |c|
  c.api_key = "your-api-key-for-applied-account"
  c.endpoint = "http://api.ai-applied.nl/"
end
```

## Usage

### Sentiment API

- [Class Documentation](docs/sentiment_details.md)
- [Examples of usage](docs/sentiment_examples.md)

```
element = Applied::Sentiment.new

options = {return_original: false, classifier: "default"}

data = [
  {text: "Sono molto contento di quello che è successo", language_iso: "ita", id: 42},
  {text: "Sono molto arrabbiato per quello che è successo", language_iso: "ita", id: 69},
  {text: "Sono molto indifferente a quello che è successo", language_iso: "ita", id: 99}
]

response = element.analyze(data, options)
```

- _[Official documentation on Applied's website](http://ai-applied.nl/api-documentation/2013/10/5/sentiment-analysis-api-documentation)_

### Text Analysis API

Coming Soon

### Text Extract API

Coming Soon

### Data Miner API

Coming Soon

### Text Label API

Coming Soon

### Demographics API

Coming Soon

### Language Detection API

Coming Soon

