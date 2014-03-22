require 'spec_helper'
require 'ostruct'

describe User do

  describe "validation tests" do

    before(:each) do
      @new_user = users(:user_1)
    end

    it "is invalid if it doesn't have a uid" do

      @new_user.uid = nil
      @new_user.should_not be_valid
    end

    it "is invalid if it doesn't have a provider" do

      @new_user.provider = nil
      @new_user.should_not be_valid
    end

    it "is invalid if it doesn't have a nickname" do

      @new_user.nickname = nil
      @new_user.should_not be_valid
    end
  end

  describe "#retrieve_or_create" do

    before(:each) do
      @auth_hash = OpenStruct.new(uid: '12345', provider: 'twitter', info: OpenStruct.new(nickname: 'eshizzle') )
    end

    it "returns user corresponding to auth_hash if user doesn't exist" do

      user = User.retrieve_or_create(@auth_hash)
      user.should be_valid
      user.nickname.should eql @auth_hash[:info][:nickname]
      user.uid.should eql @auth_hash[:uid]
      user.provider.should eql @auth_hash[:provider]
    end

    it "returns user corresponding to auth_hash if user *does* exist" do

      existing_user = User.retrieve_or_create(@auth_hash)
      existing_user.should be_valid
      existing_user.should eql users(:user_1)
    end
  end

  describe "#get_tweets" do

    # esdy: This test needs to be changed so that it doesn't retrieve live tweets from @senatorlobster.

    before(:each) do
      @auth_hash = OpenStruct.new(uid: '2371956894', provider: 'twitter', info: OpenStruct.new(nickname: 'senatorlobster') )
    end

    it "returns all tweets to @Taskaroo, @tkroo, and @tskroo" do
      user = User.retrieve_or_create(@auth_hash)
      # result.should =~ ["@tkroo Buy milk", "@tskroo write intro speech", "@Taskeroo email Sandra", "Need to pick up RUT @TKroo", "This was bizarre."]
      Rails.logger.info "Here are the test tweets: #{user.get_tweets.inspect}"
      user.get_tweets.should =~ ["@tkroo Buy milk!"]
    end

    it "returns an array of the text that was tweeted to Taskaroo" do

    end
  end
end
