namespace :tweets do

  desc "fetch and process tweets @gyardley (didn't have @taskaroo)"
  task fetch: :environment do
    Mentions.add_tasks
  end
end

class Mentions

  def self.client
    @client || set_up_twitter_client
  end

  def self.fetch_tweets
    texts = []
    mentions = self.client.mentions_timeline

    mentions.map(&:full_text).each { |x| texts << x.gsub('@gyardley','').strip }
    usernames = mentions.map(&:user).map(&:username)
    usernames.zip(texts).to_h
  end

  def self.add_tasks
    self.fetch_tweets.each do |username, task|
      if user = User.find_by(nickname: 'gyardley') # should be nickname: username, put it this way to test
        puts "Adding task to @#{username}: #{task}"
        Task.create!(list: user.lists.first, description: task)
      end
    end
  end

  private

  def self.set_up_twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TASKAROO_ACCESS_TOKEN']
      config.access_token_secret = ENV['TASKAROO_ACCESS_TOKEN_SECRET']
    end
  end

end