require 'spec_helper'

describe List do

  describe "validation tests" do
    
    before(:each) do
      @new_user = User.new(uid: '12345', provider: 'twitter', nickname: 'eshizzle')
      @new_list = List.new(name: "gazebo", user: @new_user)
    end

    it "is invalid if it doesn't have a name" do

      @new_list.name = nil
      @new_list.should_not be_valid
    end

    it "is invalid if the name is blank" do

      @new_list.name = ""
      @new_list.should_not be_valid
    end

    it "is invalid if it's not associated with a user" do
   
      @new_list.user = nil
      @new_list.should_not be_valid
    end
  end
end
