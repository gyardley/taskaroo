class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  # devise :rememberable, :trackable
  devise :omniauthable
  has_many :lists
  has_many :tasks, through: :lists

  validates :provider, :uid, :nickname, presence: true

  def self.retrieve_or_create(auth_hash)
    existing_user = User.where(:provider => auth_hash.provider, :uid => auth_hash.uid).first

    if existing_user
      return existing_user
    else
      logger.info "#{auth_hash}"
      existing_user = User.create( :provider => auth_hash.provider,
        :uid => auth_hash.uid,
        :nickname => auth_hash.info.nickname )
    end 
  end

  def get_tweets
    client = setup_twitter_client
    tweets = client.user_timeline(self.nickname)
    # logger.info "Tweets: #{tweets.inspect}"
    # logger.info "Methods: #{tweets.first.methods}"
    # logger.info "Hash: #{tweets.first.to_h.inspect}"
    tkroo_user_id = 2391196387
    # :in_reply_to_user_id
    tkroo_tweets = tweets.select{ |n| n.text if n.in_reply_to_user_id == tkroo_user_id }.map{ |n| n.text }
    logger.info "tkroo_tweets: #{tkroo_tweets.inspect}"
    tkroo_tweets
  end

  private

  def setup_twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    end
  end

end
