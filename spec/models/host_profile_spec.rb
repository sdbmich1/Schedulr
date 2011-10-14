require File.dirname(__FILE__) + '/../spec_helper'

describe HostProfile do

  before(:each) do
    @host_profile = Factory.build(:host_profile)
    @newhost_profile = Factory.create :host_profile
  end

  it "should be valid" do
    @host_profile.should be_valid
  end

    it "should have an channels method" do
      @host_profile.should respond_to(:channels)
    end

    it "should have an events method" do
      @host_profile.should respond_to(:events)
    end

    it "should have an users method" do
      @host_profile.should respond_to(:users)
    end

    it "should have an subscriptions method" do
      @host_profile.should respond_to(:subscriptions)
    end

  describe 'pictures' do
    
    before(:each) do
      @sr = @newhost_profile.pictures.create Factory.attributes_for(:picture)
    end

    it "should have a pictures method" do
      @host_profile.should respond_to(:pictures)
    end

    it "has many pictures" do
      @newhost_profile.pictures.should include(@sr)
    end
  end

end
