class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  # devise :rememberable, :trackable
  devise :omniauthable
  has_many :lists
  has_many :tasks, through: :lists

  validates :provider, :uid, :nickname, presence: true

  # TKROO_UID = 2391196387
  # TSKROO_UID = 2391203947
  # TASKAROO_UID = 2393079374
  # TASKAROO_USER_IDS = [ TKROO_UID, TSKROO_UID, TASKAROO_UID ]

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

    tweets.select do |tweet|
      tweet.user_mentions.select do |mention|
        TASKAROO_UIDS.include? mention.id
      end.length > 0 ? true : false
    end.map{ |tweet| tweet.text }
  end

  private

  def setup_twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    end
  end

end
