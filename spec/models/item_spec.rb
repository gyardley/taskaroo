require 'spec_helper'

describe Item do

  describe "validation tests" do

    before(:each) do
      @item = items(:item1_list1)
    end

    it "is invalid if it doesn't have a description" do

      @item.description = nil
      @item.should_not be_valid
    end

    it "is invalid if the description is blank" do

      @item.description = ""
      @item.should_not be_valid
    end

    it "is invalid if it's not associated with a list" do
   
      @item.list = nil
      @item.should_not be_valid
    end

    it "should not be marked completed when first created" do

      @item.completed.should be_false
      @item.completed.should_not be_nil
    end
  end
end
