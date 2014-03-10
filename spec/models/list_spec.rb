require 'spec_helper'

describe List do
  
  # validate that a list cannot be created without a name.
    # try to create a list without a name
    # assert that the list was not created

  describe "validation tests" do
    
    before(:each) do
      @new_list = List.new(name: "gazebo", user: User.new)
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
