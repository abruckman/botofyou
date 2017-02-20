require 'rubygems'
require 'dotenv'
require 'json'
require 'twitter'
require 'markov_chains'

Dotenv.load

$streaming_client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

$rest_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

def create_library(handle)
  user_tweets = []

  api_return = $rest_client.user_timeline(screen_name: handle, include_rts: false, count: 1000)
  api_return.each do |tweet|
     user_tweets << tweet.text
  end
  p user_tweets.length
  p handle

  library = user_tweets.join(" ").gsub(/http\S*\s/, "")
  library
end

def new_tweet(library, target_user)
    generator =MarkovChains::Generator.new(library)
    tweet = ''
    until tweet.length.between?(90,120)
      tweet = generator.get_sentences(1)
      tweet = tweet[0]
    end
    tweet = ".@#{target_user} " + tweet
  end

p new_tweet(create_library("cushbomb"), "botofyou")

loop do
  $streaming_client.user do |object|
    case object
      when Twitter::Tweet
        if object.user == $rest_client.user
          p "this is a repeat"
        else
          library = create_library(object.user.screen_name)
          2.times do
            reply_content = new_tweet(library, object.user.screen_name)
            reply_id = object.id
            p reply_content

            $rest_client.update(reply_content, in_reply_to_status_id: reply_id)
          end
        end
        # we are very close here also IDK about this gem
      when Twitter::DirectMessage
        puts "It's a direct message!"
      when Twitter::Streaming::StallWarning
        warn "Falling behind!"
    end
  end
end
