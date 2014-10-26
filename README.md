# [![Ruby Gem Icon](https://raw.githubusercontent.com/zenkay/ai-applied-rubymaster/rubygem.png)](https://rubygems.org/gems/applied) AI Applied Ruby Gem

[![Code Climate](https://codeclimate.com/github/zenkay/ai-applied-ruby/badges/gpa.svg)](https://codeclimate.com/github/zenkay/applied-ruby) [![Travis CI](https://travis-ci.org/zenkay/ai-applied-ruby.svg?branch=master)](https://travis-ci.org/zenkay/applied-ruby) [![Gem Version](https://badge.fury.io/rb/applied.svg)](http://badge.fury.io/rb/applied) [![Coverage Status](https://coveralls.io/repos/zenkay/ai-applied-ruby/badge.png?branch=master)](https://coveralls.io/r/zenkay/applied-ruby?branch=master)

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

[...]