require File.dirname(__FILE__) + '/../spec_helper'

describe SponsorPage do
  it "should be valid" do
    SponsorPage.new.should be_valid
  end
end
