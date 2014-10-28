# Sentiment API

- [Setup](#setup)
- [Parameters](#parameters)
- [Response](#response)

## Setup

First you need to configure your account adding your API key. Endpoint sohould be always the same but I keep it configurable.

```
Applied.configure do |c|
  c.api_key = "your-api-key-for-applied-account"
  c.endpoint = "http://api.ai-applied.nl/"
end
```

Then you need to create a new ```Sentiment``` object

```
element = Applied::Sentiment.new
```

## Parameters

The ```analyze``` method takes two parameters: ```data``` and ```options```.

### data

The ```data``` parameter contains text you need to analyze with additional informations. Here is an example item:

```
{
  text: "Sono molto contento di quello che è successo",
  language_iso: "ita",
  id: 42
}
```

| Parameter | Mandatory | Description |
| --------- | --------- | ----------- |
| text | yes | The message text as a string |
| language_iso | yes | Specifying the language of this individual message (```eng``` for English, ```nld``` for Dutch, ```deu``` for German, ```fra``` for French, ```spa``` for Spanish, ```ita``` for Italian, ```rus``` for Russian) |
| id | yes | Unique message ID as a string or an integer you could use to identify your messages into response |

Data item should be placed into an Array.
You could send more than one message in a single call.

```
data = [
  {text: "Sono molto contento di quello che è successo", language_iso: "ita", id: 42},
  {text: "Sono molto arrabbiato per quello che è successo", language_iso: "ita", id: 69},
  {text: "Sono molto indifferente a quello che è successo", language_iso: "ita", id: 99}
]
```

### options

| Parameter | Mandatory | Default | Description |
| --------- | --------- | ------- | ----------- |
| return_original | yes | false | Return full posted messages (true) together with the language annotation or only the message id's (false) annotated with language |
| classifier | yes | "default" | Specifies which classifier to use. Sentiment Analysis API offers two standard classifiers, "default" and "subjective". The "default" classifier provides a two-class classification ("positive"/"negative"), while the "subjective" classifier provides the "neutral" class as well. |

```
options = {
  return_original: false, 
  classifier: "default"
}
```

## Response

```
response = element.analyze(data, options)
```

Ai Applied return a JSON data that is parsed to a Ruby Hash.

```
{
  "status" => 1, 
  "id" => nil, 
  "response" => {
    "data" => [
      {"confidence_sentiment" => 0.735094833636812, "sentiment_class" => "positive", "id" => 42}, 
      {"confidence_sentiment" => 0.9914339753287233, "sentiment_class" => "negative", "id" => 69}, 
      {"confidence_sentiment" => 0.7537000605846166, "sentiment_class" => "negative", "id" => 99}
    ], 
    "description" => "OK: Call processed.", 
    "success" => true
  }
}
```