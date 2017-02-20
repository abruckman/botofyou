# Bot Of You

This is the source code for Bot Of You, a twitter bot that imitates the style of anyone who tweets at it. It's the final iteration of my previous project You Robot, which generated a tweet length string from another user's timeline.

Here's how it works:
 
1. It listens using the Twitter Streaming API for interactions with the bot account.

2. When someone @'s the bot, the bot uses the REST API to grab all their tweets off their timeline.

3. I use those tweets as a library for the Markov Chains ruby gem.


