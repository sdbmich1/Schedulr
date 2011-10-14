require File.dirname(__FILE__) + '/../spec_helper'

describe EventsController do
#  render_views

  def mock_event(stubs={})
    (@mock_event ||= mock_model(Event, stubs).as_null_object).tap do |event|
       event.stub(stubs) unless stubs.empty?
    end
  end

  before :each do
    @event = stub_model(Event, :id=>1, :event_title=>"test")
  end

  describe 'GET index' do

    it "should load events" do
      get :index 
      response.code.should eq ("200")
    end

    it "should assign @events" do
      @events = [@event, @event]
      Event.should_receive(:get_events).and_return(@events)
      get :index 
      assigns[:events].should == @events
    end

    it "index action should render index template" do
      get :index
      response.should render_template(:index)
    end
  end

  describe 'GET show/:id' do

    before :each do
      Event.stub!(:find).and_return( @event )
    end

    def do_get
      get :show, :id => @event
    end

    it "should load the requested event" do
      do_get
      response.should be_success
    end

    it "should load the requested event" do
      Event.stub(:find).with(@event.id).and_return(@event)
      do_get
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
    end

    it "should assign @event" do
      get :new
      assigns[:event].should == @event
    end

    it "new action should render new template" do
      get :new
      response.should render_template(:new)
    end

  end

  describe "POST create" do
    
    context 'failure' do
      
      before :each do
        @event.stub!(:save).and_return(false)
      end

      it "should assign @event" do
        post :create
        assigns(:event).should_not be_nil 
      end

      it "should render the new template" do
        post :create
        response.should render_template(:new)
      end
    end

    context 'success' do

      it "assigns a newly created event as @event" do
        Event.stub(:new).with({'these' => 'params'}) { mock_event(:save => true) }
        post :create, :event => {'these' => 'params'}
        assigns(:event).should be(mock_event)
      end

      it "redirects to the created event" do
        Event.stub(:new) { mock_event(:save => true) }
        post :create, :event => {}
        response.should redirect_to(event_url(mock_event))
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
    end

    def do_get
      get :edit, :id => @event
    end

    it "should load the requested event" do
      Event.stub(:find).with(@event.id).and_return(@event)
      do_get
    end

    it "should assign @event" do
      do_get
      assigns(:event).should_not be_nil 
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
        Event.stub(:find).with("12") { @mock_event }
      end

      it "should load the requested event" do
        Event.stub(:find).with("12").and_return(@event)
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
	response.should redirect_to(event_url(mock_event))
      end
    end

    context "with invalid params" do
    
      before (:each) do
        mock_event(:update_attributes => false)
        Event.stub(:find).with("12") { @mock_event }
      end

      it "should load the requested event" do
        Event.stub(:find).with("12").and_return(@event)
      end

      it "should assign @event" do
	put :update, :id => "12"
        assigns(:event).should_not be_nil 
      end

      it "renders the edit form" do 
        Event.stub(:find).with("12") { mock_event(:update_attributes => false) }
	put :update, :id => "12"
	response.should render_template(:edit)
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
    end

    def do_get
      get :clone, :id => @event
    end

    context "when success" do

      it "should be successful" do
        Event.stub_chain(:find, :clone_event, :set_associations).with(@event.id).and_return(true)
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

      it "should assign @event" do
        do_get
        assigns[:event].should == @event
      end

      it "should render clone template" do
        do_get
        response.should render_template('clone')
      end  

    end

    context "when unsuccessful" do
      before :each do
        Event.stub_chain(:find, :clone_event, :set_associations).and_return(false)
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
