require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../login_user_spec'

describe ChannelsController do
  include LoginTestUser

  def mock_channel(stubs={})
    (@mock_channel ||= mock_model(Channel, stubs).as_null_object).tap do |channel|
       channel.stub(stubs) unless stubs.empty?
    end
  end

  def mock_event(stubs={})
    (@mock_event ||= mock_model(Event, stubs).as_null_object).tap do |event|
       event.stub(stubs) unless stubs.empty?
    end
  end

  before :each do
    log_in_test_user
    @channel = stub_model(Channel, :id=>1)
  end

  describe 'GET show/:id' do

    before :each do
      @event = stub_model(Event) 
      Event.stub!(:find_events).and_return( @event )
      Channel.stub!(:find).and_return(@channel)
      @channel.stub_chain(:pictures).and_return(@picture)
    end

    def do_get
      get :show, :id => '1'
    end

    it "should load the requested event" do
      do_get
      response.should be_success
    end

    it "should load the requested event" do
      Event.stub(:find).and_return(@event)
      do_get
    end

    it "should assign channel" do
      Channel.should_receive(:find).with('1').and_return(@channel)
      do_get
      assigns(:channel).should_not be_nil
    end

    it "should assign @event" do
      do_get
      assigns(:event).should be_nil
    end

    it "show action should render show template" do
      do_get
      response.should render_template(:show)
    end
  end

  describe "GET 'new'" do

    before :each do
      @categories = mock("categories")
      Category.stub!(:get_active_list).and_return(@categories)
      @channel = stub_model(Channel) 
      Channel.stub_chain(:new, :HostProfileID, :ProfileID).and_return(@channel)
      controller.stubs(:set_associations).returns(true)
      @channel.stub!(:pictures).and_return(@picture)
      @channel.stub!(:channel_interests).and_return(@channel_interests)
    end

    def do_get
      get :new
    end

    it "new action should render new template" do
      do_get
      response.should render_template(action: 'new')
    end

    it "should assign channel" do
      Channel.should_receive(:new).and_return(@channel)
      do_get
      assigns(:channel).should_not be_nil
    end

  end

  describe "POST create" do
    
    context 'failure' do
      
      before :each do
        Channel.stub!(:new).and_return(@channel)
        @channel.stub!(:save).and_return(false)
      end

      it "should assign @channel" do
        post :create
        assigns(:channel).should_not be_nil 
      end

      it "should render the new template" do
        post :create
        response.should render_template(action: 'new')
      end
    end

    context 'success' do

      it "assigns a newly created channel as @channel" do
        Channel.stub!(:new).with({'these' => 'params'}) { mock_channel(:save => true) }
        post :create, :channel => {'these' => 'params'}
      end

      it "should assign @channel" do
        post :create, :channel => {}
        assigns(:channel).should_not be_nil 
      end

      it "redirects to the created channel" do
        Channel.stub!(:new) { mock_channel(:save => true) }
        post :create, :channel => {}
        response.should be_redirect
      end

      it "should change channel count" do
        lambda do
          post :create, :channel => {} 
          should change(Channel, :count).by(1)
        end
      end
    end
  end
end
