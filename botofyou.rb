require_relative 'make_robots.rb'


loop do
  $streaming_client.user do |object|
    case object
      when Twitter::Tweet
        if object.user == $rest_client.user
          p "this is a repeat"
        else
          library = create_library(object.user.screen_name)
          reply_content = new_tweet(library, object.user.screen_name)
          reply_id = object.id
          p reply_content

          $rest_client.update(reply_content, in_reply_to_status_id: reply_id)
        end
        # we are very close here also IDK about this gem
      when Twitter::DirectMessage
        puts "It's a direct message!"
      when Twitter::Streaming::StallWarning
        warn "Falling behind!"
    end
  end
end
