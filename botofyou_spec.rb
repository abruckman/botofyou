require 'rspec'
require_relative 'botofyou.rb'

describe "twitter client works" do
  it "makes a call to the twitter API" do
    expect ($rest_client.user_timeline(screen_name: "dril", include_rts: false, count: 1000)).to include(a_kind_of(Twitter::Tweet))
  end

end

describe "makes tweets for user " do
  let (library){create_library("dril")}
  it "makes turns user timeline into a markov_chains library" do
    expect(create_library("dril")).to be_a_kind_of(String)
  end
  it "uses the library to make a tweet" do
    expect(new_tweet(create_libary)).to be(a_kind_of("string"))

    expect(new_tweet(create_libary).length).to be_between(90, 140)
  end

end
