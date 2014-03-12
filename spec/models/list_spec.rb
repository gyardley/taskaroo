require 'spec_helper'

describe List do

  describe "validation tests" do
    
    before(:each) do
      @new_user = users(:user_1)
      @new_list = @new_user.lists.first
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
