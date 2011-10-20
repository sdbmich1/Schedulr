require File.dirname(__FILE__) + '/../spec_helper'

describe Sponsor do
  it "should be valid" do
    Sponsor.new.should be_valid
  end
end
