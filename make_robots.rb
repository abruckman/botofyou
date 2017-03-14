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
  count = 0
  until tweet.length.between?(90,120)

    tweet = generator.get_sentences(1)
    tweet = tweet[0]
    count += 1
    if count >= 75 && count < 120 && tweet.length > 120
      tweet = tweet.slice(0, 119)
    elsif count >=300
      tweet = "uh-oh looks like I short circuted, if you try again, theres a 30% chance it works!"
    end

  end
  tweet = ".@#{target_user} " + tweet
end

def check_fails(library, target_user)
  fails = 0
  too_big = 0
  too_short = 0
  200.times do
    generator =MarkovChains::Generator.new(library)
    tweet = ''
    count = 0
    until tweet.length.between?(65,120)

      tweet = generator.get_sentences(1)
      tweet = tweet[0]
      count += 1
      if tweet.length > 120
        too_big +=1
      elsif tweet.length < 65
        too_short +=1
      end
      if count >= 75 && count < 120 && tweet.length > 120
        tweet = tweet.slice(0, 119)
      elsif count >=300
        tweet = "uh-oh looks like I short circuted, if you try again, theres a 30% chance it works!"
        fails += 1
      end

    end
    tweet = ".@#{target_user} " + tweet
  end
  p "too big"
  p too_big
  p "too shor"
  p too_short
  p "fail rate"
  p fails
end


check_library = create_library("cushbomb")

check_fails(check_library, "cushbomb")
3.times do
  p new_tweet(create_library(cushbomb), "cushbomb")
end
