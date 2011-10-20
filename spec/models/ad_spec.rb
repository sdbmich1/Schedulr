require File.dirname(__FILE__) + '/../spec_helper'

describe Ad do
  it "should be valid" do
    Ad.new.should be_valid
  end
end
