# Bot Of You

This is the source code for [Bot Of You](https://twitter.com/BotOfYou), a twitter bot that imitates the style of anyone who tweets at it. It's the final iteration of my previous project You Robot, which generated a tweet length string from another user's timeline.

Here's how it works:
 
1. It listens using the Twitter Streaming API for interactions with the bot account.

2. When someone @'s the bot, the bot uses the REST API to grab their last 200 or so tweets off their timeline.

3. BotOfYou cleans those tweets up to use as training data for the Markov Chains ruby gem.

4. BotOfYou uses the Markov Chains ruby gem to generate two sentences with 100-120 characters each to use as tweets.

5. BotofYou post those two sentences as tweets in reply to the post that @'d me in the first place (two because that increases the chance one of them will be good)

## Installation

If you want to set this bot up to run yourself it's not too hard. 

* clone the repo and bundle install

* set up an account with Twitter and get the API Keys. make a folder called ".env" in the main directory and put your keys in it like this 

```
CONSUMER_KEY=XXXXX
CONSUMER_SECRET=XXXXX
ACCESS_TOKEN=XXXXX
ACCESS_TOKEN_SECRET=XXXXX
```

* just run the file like a normal ruby file from the comand line
```
$ ruby botofyou.rb
```

* and you're off to the races!


Special thanks to SFErik for the twitter gem and justindomingue for the markov chain gem.


