require File.dirname(__FILE__) + '/../spec_helper'

describe SessionRelationshipsController do

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

  def mock_session_relationship(stubs={})
    (@mock_session_relationship ||= mock_model(SessionRelationship, stubs).as_null_object).tap do |session_relationship|
       session_relationship.stub(stubs) unless stubs.empty?
    end
  end

  before :each do
    @event = mock_model(Event) 
    @session_event = stub_model(Event) 
    @presenters = mock("presenters")
    @event.stub!(:presenters).and_return(@presenters)
  end

  describe 'GET show/:id' do

    before :each do
      Event.stub!(:find).and_return(@event)
      @session_event.stub_chain(:presenters, :paginate).and_return(@presenters)
      @session_event.stub!(:pictures).and_return(@picture)
    end

    def do_get
      get :show, :event_id => 1, :id => '1'
    end

    it "should load the requested session" do
      Event.should_receive(:find).with('1').and_return(@session_event)
      do_get
    end

    it "should assign session" do
      Event.should_receive(:find).with('1').and_return(@session_event)
      do_get
      assigns(:session_event).should_not be_nil
    end

    it "show action should render show template" do
      Event.should_receive(:find).with('1').and_return(@session_event)
      do_get
      response.should render_template(:show)
    end
  end

  describe "GET 'new'" do

    before :each do
      @event = stub_model(Event) 
      Event.stub!(:find).and_return(@event)
      Event.stub_chain(:new, :attributes, :reset_session_values).and_return(@session_event)
      @session_event.stub_chain(:pictures, :build).and_return(@picture)
    end

    def do_get
      get :new, :event_id => 1 
    end

    it "should assign @session_event" do
      Event.stub(:new) { mock_event }
      do_get
      assigns(:session_event).should_not be_nil
    end

    it "new action should render new template" do
      Event.stub(:new) { mock_event }
      do_get
      response.should render_template(:new)
    end
  end

  describe "POST create" do
    
    context 'failure' do
      
      before :each do
        Event.stub!(:find).and_return(@event)
        Event.stub!(:new).and_return(@session_event)
        @session_event.stub!(:save).and_return(false)
      end

      def do_create
        post :create, :event_id => 1 
      end

      it "should assign @session_event" do
        do_create
        assigns(:session_event).should_not be_nil 
      end

      it "should render the new template" do
        do_create
        response.should render_template(:new)
      end
    end

    context 'success' do

      before :each do
        @event = stub_model(Event) 
        Event.stub!(:find).and_return(@event)
        Event.stub!(:new).and_return(@session_event)
        @session_event.stub!(:save).and_return(true)
	@event.stub_chain(:create, :session_relationships)
      end

      def do_create
        post :create, :event_id => 1, :id => 1, :event => {'name'=>'test'}
      end

      it "should load the requested session event" do
        Event.stub(:new).with({'name'=>'test'}) { mock_event(:save => true) }
        do_create
      end

      it "should assign @session_event" do
        do_create
        assigns(:session_event).should_not be_nil 
      end

      it "should create @session_event relationship " do
        do_create
	response.should be_true
      end

      it "redirects to the parent event" do
        Event.stub(:new).with({'name'=>'test'}) { mock_event(:save => true) }
        do_create
        response.should be_redirect
      end

      it "should change event count" do
        lambda do
          do_create
          should change(Event, :count).by(1)
        end
      end

      it "should change session count" do
        lambda do
          do_create
          should change(SessionRelationship, :count).by(1)
        end
      end
    end
  end

  describe "GET 'edit/:id'" do

    before :each do
      @event = stub_model(Event) 
      Event.stub!(:find).and_return(@event)
      Event.stub(:find).and_return(@session_event)
      @session_event.stub_chain(:pictures, :build).and_return(@picture)
    end

    def do_get
      get :edit, :event_id => 1, :id => '1'
    end

    it "should load the requested session" do
      Event.should_receive(:find).with('1').and_return(@session_event)
      do_get
    end

    it "should assign session" do
      Event.should_receive(:find).with('1').and_return(@session_event)
      do_get
      assigns(:session_event).should_not be_nil
    end

    it "edit action should render edit template" do
      Event.should_receive(:find).with('1').and_return(@session_event)
      do_get
      response.should render_template(:edit)
    end
  end

  describe "PUT /:id" do

    before (:each) do
      @event = stub_model(Event) 
      Event.stub!(:find).and_return(@event)
      Event.stub!(:new).and_return(@session_event)
    end

    context "with valid params" do
    
      before (:each) do
        @session_event.stub(:update_attributes).and_return(true)
      end

      def do_update
        put :update, :event_id => 1, :id => "1", :event => {'name'=>'test'}
      end

      it "should load the requested session event" do
        Event.stub(:find) { @session_event }
        do_update
      end

      it "should update the requested session event" do
        Event.stub(:find).with("1") { mock_event }
	mock_event.should_receive(:update_attributes).with({'name' => 'test'})
        do_update
      end

      it "should assign @session_event" do
        Event.stub(:find) { mock_event(:update_attributes => true) }
        do_update
        assigns(:session_event).should_not be_nil 
      end

      it "redirects to the event page" do
        Event.stub(:find) { mock_event(:update_attributes => true) }
        do_update
        response.should be_redirect
      end
    end

    context "with invalid params" do
    
      before (:each) do
        @session_event.stub(:update_attributes).and_return(false)
      end

      def do_update
        put :update, :event_id => 1, :id => "1"
      end

      it "should load the requested session event" do
        Event.stub(:find) { @session_event }
        do_update
      end

      it "should assign @session_event" do
        Event.stub(:find) { mock_event(:update_attributes => false) }
        do_update
        assigns(:session_event).should_not be_nil 
      end

      it "renders the edit form" do 
        Event.stub(:find) { mock_event(:update_attributes => false) }
        do_update
	response.should render_template(:edit)
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before (:each) do
      @event = stub_model(Event) 
      Event.stub!(:find).and_return(@event)
      @session_relationship = stub_model(SessionRelationship) 
      SessionRelationship.stub!(:find_by_session_id).and_return(@session_relationship)
      @session_relationship.stub(:destroy).and_return(true)
      @request.env['HTTP_REFERER'] = "http://referer/"
    end

    def do_delete
      delete :destroy, :event_id => "1", :id => "37"
    end

    context 'success' do

      it "should load the requested session_relationship" do
        SessionRelationship.stub(:find_by_session_id).with("37").and_return(@session_relationship)
        do_delete
      end

      it "destroys the requested session_relationship" do
        SessionRelationship.stub(:find_by_session_id).with("37") { mock_session_relationship }
        mock_session_relationship.should_receive(:destroy)
        do_delete
      end

      it "redirects to the session_relationships list" do
        SessionRelationship.stub(:find_by_session_id) { mock_session_relationship }
        do_delete
        response.should be_redirect
      end
    end

  end
end
