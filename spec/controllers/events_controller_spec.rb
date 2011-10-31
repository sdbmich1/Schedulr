require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../login_user_spec'

describe EventsController do
  include LoginTestUser

  def mock_event(stubs={})
    (@mock_event ||= mock_model(Event, stubs).as_null_object).tap do |event|
       event.stub(stubs) unless stubs.empty?
    end
  end

  def mock_presenter(stubs={})
    (@mock_presenter ||= mock_model(Presenter, stubs).as_null_object).tap do |presenter|
       presenter.stub(stubs) unless stubs.empty?
    end
  end

  def mock_channel(stubs={})
    (@mock_channel ||= mock_model(Channel, stubs).as_null_object).tap do |channel|
       channel.stub(stubs) unless stubs.empty?
    end
  end

  before :each do
    log_in_test_user
    @event = stub_model(Event, :id=>1, :event_title=>"test")
  end

  describe 'GET show/:id' do

    before :each do
      @presenters = mock("presenters")
      @sponsor_pages = mock("sponsor_pages")
      Event.stub!(:find).and_return( @event )
      @event.stub!(:presenters).and_return(@presenters)
      @event.stub!(:sponsor_pages).and_return(@sponsor_pages)
      @channel = stub_model(Channel) 
      Channel.stub_chain(:find).and_return(@channel)
      @event.stub_chain(:presenters, :paginate).and_return(@presenters)
      @event.stub_chain(:sessions, :paginate).and_return(@sessions)
    end

    def do_get
      get :show, :id => @event, :cid => '1'
    end

    it "should load the requested event" do
      do_get
      response.should be_success
    end

    it "should load the requested event" do
      Event.stub(:find).with(@event.id).and_return(@event)
      do_get
    end

    it "should assign channel" do
      Channel.should_receive(:find).with('1').and_return(@channel)
      do_get
      assigns(:channel).should_not be_nil
    end

    it "should assign @event" do
      do_get
      assigns(:event).should_not be_nil
    end

    it "show action should render show template" do
      do_get
      response.should render_template(:show)
    end
  end

  describe "GET 'new'" do

    before :each do
      Event.stub!(:new).and_return( @event )
      @channel = stub_model(Channel) 
      Channel.stub_chain(:find).and_return(@channel)
      controller.stubs(:set_associations).returns(true)
      @event.stub(:pictures).and_return(@picture)
      @event.stub(:event_tracks).and_return(@event_tracks)
      @event.stub(:event_sites).and_return(@event_sites)
    end

    def do_get
      get :new, :cid => '1'
    end

    it "should assign @event" do
      do_get
      assigns[:event].should == @event
    end

    it "new action should render new template" do
      do_get
      response.should render_template(:new)
    end

    it "should assign channel" do
      Channel.should_receive(:find).with('1').and_return(@channel)
      do_get
      assigns(:channel).should_not be_nil
    end

  end

  describe "POST create" do
    
    context 'failure' do
      
      before :each do
        Event.stub_chain(:new, :reset_dates).and_return(@event)
        @event.stub!(:save).and_return(false)
      end

      it "should assign @event" do
        post :create
        assigns(:event).should be_nil 
      end

      it "should render the new template" do
        post :create
        response.should render_template(action: 'new')
      end
    end

    context 'success' do

      it "assigns a newly created event as @event" do
        Event.stub_chain(:new, :reset_dates).with({'these' => 'params'}) { mock_event(:save => true) }
        post :create, :event => {'these' => 'params'}
      end

      it "should assign @event" do
        post :create, :event => {}
        assigns(:event).should_not be_nil 
      end

      it "redirects to the created event" do
        Event.stub_chain(:new, :reset_dates) { mock_event(:save => true) }
        post :create, :event => {}
        response.should be_redirect
      end

      it "should change event count" do
        lambda do
          post :create, :event => {} 
          should change(Event, :count).by(1)
        end
      end
    end
  end

  describe "GET 'edit/:id'" do

    before :each do
      Event.stub!(:find).and_return( @event )
      @event.stub_chain(:set_associations, :pictures).and_return(@picture)
      @event.stub_chain(:set_associations, :event_tracks).and_return(@event_tracks)
      @event.stub_chain(:set_associations, :event_sites).and_return(@event_sites)
      controller.stubs(:set_associations).returns(true)
      @channel = mock_model(Channel) 
      Channel.stub_chain(:find).and_return(@channel)
    end

    def do_get
      get :edit, :id => @event, :cid => '1'
    end

    it "should load the requested event" do
      Event.stub(:find).with(@event.id).and_return(@event)
      do_get
    end

    it "should assign @event" do
      do_get
      assigns(:event).should_not be_nil 
    end

    it "should assign channel" do
      Channel.should_receive(:find).with('1').and_return(@channel)
      do_get
      assigns(:channel).should_not be_nil
    end

    it "should load the requested event" do
      do_get
      response.should be_success
    end
  end

  describe "PUT /:id" do

    context "with valid params" do
    
      before (:each) do
        mock_event(:update_attributes => true)
        Event.stub_chain(:find, :reset_dates).with("12") { @mock_event }
      end

      it "should load the requested event" do
        Event.stub_chain(:find, :reset_dates).with("12").and_return(@event)
      end

      it "updates the event" do
	put :update, :id => "12"
      end

      it "should assign @event" do
	put :update, :id => "12"
        assigns(:event).should_not be_nil 
      end

      it "redirects to the event" do
	put :update, :id => "12"
        response.should be_redirect
      end
    end

    context "with invalid params" do
    
      before (:each) do
        mock_event(:update_attributes => false)
        Event.stub_chain(:find, :reset_dates).with("12") { @mock_event }
      end

      it "should load the requested event" do
        Event.stub_chain(:find, :reset_dates).with("12").and_return(@event)
      end

      it "should assign @event" do
	put :update, :id => "12"
        assigns(:event).should_not be_nil 
      end

      it "renders the edit form" do 
        Event.stub_chain(:find, :reset_dates).with("12") { mock_event(:update_attributes => false) }
	put :update, :id => "12"
	response.should render_template(action: 'edit')
      end
    end
  end

  describe "DELETE 'destroy'" do

    context 'success' do

      it "should load the requested event" do
        Event.stub(:find).with("37").and_return(@event)
      end

      it "destroys the requested event" do
        Event.stub(:find).with("37") { mock_event }
        mock_event.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the events list" do
        Event.stub(:find) { mock_event }
        delete :destroy, :id => "1"
        response.should redirect_to(events_url)
      end
    end

  end

  describe "GET 'clone'" do

    before :each do
      @event = stub_model(Event, :id => 1)
      Event.stub_chain(:find, :clone_event).and_return(@event)
      @event.stub_chain(:set_associations, :pictures).and_return(@picture)
      @event.stub_chain(:set_associations, :event_tracks).and_return(@event_tracks)
      @event.stub_chain(:set_associations, :event_sites).and_return(@event_sites)
      controller.stubs(:set_associations).returns(true)
      @channel = stub_model(Channel) 
      Channel.stub_chain(:find).and_return(@channel)
    end

    def do_get
      get :clone, :id => @event, :cid => '1'
    end

    context "when success" do

      it "should be successful" do
        Event.stub_chain(:find, :clone_event).with(@event.id).and_return(true)
        do_get
      end    

      it "should have pictures method" do
        do_get
        @event.stub!(:pictures).and_return(true)
      end

      it "should have event_tracks method" do
        do_get
        @event.stub!(:event_tracks).and_return(true)
      end

      it "should have event_sites method" do
        do_get
        @event.stub!(:event_sites).and_return(true)
      end

      it "should assign @event" do
        do_get
        assigns[:event].should == @event
      end

    it "should assign channel" do
      Channel.should_receive(:find).with('1').and_return(@channel)
      do_get
      assigns(:channel).should_not be_nil
    end

      it "should render clone template" do
        do_get
	response.should render_template(action: 'clone')
      end  

    end

    context "when unsuccessful" do
      before :each do
        Event.stub_chain(:find, :clone_event).and_return(false)
      end

      it "should not create an event" do
        lambda do
          do_get
          should_not change(Event, :count)
        end
      end
    end

  end
end
