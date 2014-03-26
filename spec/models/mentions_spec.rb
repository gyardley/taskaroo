require 'spec_helper'

describe Mentions do

  before(:each) do
    @brent = User.create(uid: '123', provider: 'twitter', nickname: 'bhalliburton')
    @jerry = User.create(uid: '456', provider: 'twitter', nickname: 'ganeumann')
    @jdg   = User.create(uid: '123', provider: 'twitter', nickname: 'jdg')
    @erin  = User.create(uid: '456', provider: 'twitter', nickname: 'Erinelizs')
    List.create(user: @brent, name: "Brent's Tasks")
    List.create(user: @jerry, name: "Jerry's Tasks")
    List.create(user: @jdg, name: "Jonathan's Tasks")
    List.create(user: @erin, name: "Erin's Tasks")
  end

  it "fetches the new user's tweets" do
    Mentions.add_tasks
    @brent.tasks.count.should eq 1
    @jerry.tasks.count.should eq 1
    @jdg.tasks.count.should eq 1
    @erin.tasks.count.should eq 1
  end

end