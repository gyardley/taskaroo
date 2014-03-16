require 'spec_helper'

describe Task do

  describe "validation tests" do

    before(:each) do
      @task = tasks(:task1_list1)
    end

    it "is invalid if it doesn't have a description" do

      @task.description = nil
      @task.should_not be_valid
    end

    it "is invalid if the description is blank" do

      @task.description = ""
      @task.should_not be_valid
    end

    it "is invalid if it's not associated with a list" do
   
      @task.list = nil
      @task.should_not be_valid
    end

    it "should not be marked completed when first created" do

      @task.completed.should be_false
      @task.completed.should_not be_nil
    end
  end
end
