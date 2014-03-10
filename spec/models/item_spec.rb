require 'spec_helper'

describe Item do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "validation tests" do

    before(:each) do
      @new_item = Item.new(description: "lakehouse", list: List.new)
    end

    it "is invalid if it doesn't have a description" do

      @new_item.description = nil
      @new_item.should_not be_valid
    end

    it "is invalid if the description is blank" do

      @new_item.description = ""
      @new_item.should_not be_valid
    end

    it "is invalid if it's not associated with a list" do
   
      @new_item.list = nil
      @new_item.should_not be_valid
    end

    it "should not be marked completed when first created" do

      @new_item.completed.should be_false
      @new_item.completed.should_not be_nil
    end

  end

  describe "#date_created_on" do

    it "should show the date this item was created on in the format Month DD, YYYY" do

    end

    it ""
  end

end
