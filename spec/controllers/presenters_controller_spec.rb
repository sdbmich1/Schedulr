require File.dirname(__FILE__) + '/../spec_helper'
require 'login_user_spec'

describe PresentersController do
#  render_views
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
    @event = mock_model(Event) 
    @parent_event = stub_model(Event) 
    @channel = stub_model(Channel) 
    Event.stub!(:find).and_return(@parent_event)
    @presenters = mock("presenters")
    @event.stub!(:presenters).and_return(@presenters)
  end

  describe 'GET index' do

    before do
      Presenter.stub!(:get_list).and_return(@presenters)
    end

    def do_get
      get :index, :event_id => 1, :parent_id => '50' 
    end

    it "should load presenters" do
      do_get
      response.code.should eq ("200")
    end

    it "should get event's presenters" do
      Presenter.should_receive(:get_list).and_return(@presenters)
      do_get
    end

    it "should assign @presenters" do
      do_get
      assigns[:presenters].should_not be_nil
    end

    it "should assign @event" do
      do_get
      assigns[:event].should_not be_nil
    end

    it "should assign @parent_event" do
      do_get
      assigns[:parent_event].should_not be_nil
    end

    it "index action should render index template" do
      do_get
      response.should render_template(:index)
    end
  end

  describe 'GET show/:id' do

    before :each do
      @presenter = stub_model(Presenter)
      Event.stub!(:find).and_return(@event)
      @event.stub!(:presenter).and_return(@presenter)
      Presenter.should_receive(:find).with('1').and_return(@presenter)
    end

    def do_show
      get :show, :event_id => '1', :id => '1', :parent_id => '50' 
    end

    it "should load the requested presenter" do
      do_show
    end

    it "should assign @presenter" do
      do_show
      assigns(:presenter).should_not be_nil
    end

    it "should assign @event" do
      Event.should_receive(:find).with('1').and_return(@event)
      do_show
      assigns[:event].should_not be_nil
    end

    it "should assign @parent_event" do
      Event.should_receive(:find).with('50').and_return(@parent_event)
      do_show
      assigns[:parent_event].should_not be_nil
    end

    it "show action should render show template" do
      do_show
      response.should render_template(:show)
    end
  end

  describe "GET 'new'" do

    before :each do
      @event = stub_model(Event) 
      @presenter = stub_model(Presenter)
      @picture = stub_model(Picture)
      @presenter.stub_chain(:pictures, :contact_details, :build).and_return(@picture)
      Presenter.stub(:new) { mock_presenter }
    end

    def do_get
      get :new, :event_id => 1, :parent_id => 50 
    end

    it "should assign @presenter" do
      do_get
      assigns(:presenter).should_not be_nil
    end

    it "should assign @parent_event" do
      do_get
      assigns[:parent_event].should_not be_nil
    end

    it "should assign @picture" do
      do_get
      assigns(:picture).should_not be_nil
    end

    it "new action should render new template" do
      do_get
      response.should render_template(:new)
    end
  end

  describe "POST create" do
    
    context 'failure' do
      
      before :each do
        @event = stub_model(Event) 
        Event.stub!(:find).and_return(@event)
        Presenter.stub!(:save).and_return(false)
      end

      def do_create
        post :create, :event_id => 1
      end

      it "should assign @presenter" do
        do_create
        assigns(:presenter).should_not be_nil 
      end

      it "should assign @event" do
        do_create
        assigns[:event].should_not be_nil
      end

      it "should render the new template" do
        do_create
        response.should render_template(:new)
      end
    end

    context 'success' do

      before :each do
        @event = stub_model(Event) 
        @presenter = mock_model(Presenter)
        Event.stub!(:find).and_return(@event)
        Presenter.stub!(:save).and_return(true)
      end

      def do_create
        post :create, :event_id => 1, :presenter => {'name'=>'test'}
      end

      it "should load the requested presenter" do
        Presenter.stub(:new).with({'name'=>'test'}) { mock_presenter(:save => true) }
        do_create
      end

      it "should assign @presenter" do
        do_create
        assigns(:presenter).should_not be_nil 
      end

      it "should assign @event" do
        do_create
        assigns[:event].should_not be_nil
      end

      it "redirects to the created presenter" do
        Presenter.stub(:new).with({'name'=>'test'}) { mock_presenter(:save => true) }
        do_create
        response.should be_redirect
      end

      it "should change presenter count" do
        lambda do
          do_create
          should change(Presenter, :count).by(1)
        end
      end
    end
  end

  describe "GET 'edit/:id'" do

    before :each do
      @presenter = stub_model(Presenter)
      Event.stub!(:find).and_return(@event)
      Event.stub!(:find).and_return(@parent_event)
      Presenter.stub!(:find).and_return( @presenter )
      @picture = stub_model(Picture)
      @presenter.stub_chain(:pictures, :contact_details, :build).and_return(@picture)
    end

    def do_get
      get :edit, :event_id => '1', :id => '1', :parent_id => '50'
    end

    it "should load the requested presenter" do
      Presenter.should_receive(:find).with('1').and_return(@presenter)
      do_get
    end

    it "should assign @presenter" do
      do_get
      assigns(:presenter).should_not be_nil 
    end

    it "should assign @event" do
      Event.should_receive(:find).with('1').and_return(@event)
      do_get
      assigns[:event].should_not be_nil
    end

    it "should assign @parent_event" do
      Event.should_receive(:find).with('50').and_return(@parent_event)
      do_get
      assigns[:parent_event].should_not be_nil
    end

    it "should load the requested presenter" do
      do_get
      response.should be_success
    end
  end

  describe "PUT /:id" do

    before (:each) do
      @presenter = stub_model(Presenter)
      Event.stub!(:find).and_return(@event)
      Event.stub!(:find).and_return(@parent_event)
      @event.stub!(:presenter).and_return(@presenter)
    end

    context "with valid params" do
    
      before (:each) do
        @presenter.stub(:update_attributes).and_return(true)
      end

      def do_update
        put :update, :event_id => 1, :id => "1", :parent_id => '50', :presenter => {'name'=>'test'}
      end

      it "should load the requested presenter" do
        Presenter.stub(:find) { @presenter }
        do_update
      end

      it "should update the requested presenter" do
        Presenter.stub(:find).with("1") { mock_presenter }
	mock_presenter.should_receive(:update_attributes).with({'name' => 'test'})
        do_update
      end

      it "should assign @presenter" do
        Presenter.stub(:find) { mock_presenter(:update_attributes => true) }
        do_update
        assigns(:presenter).should_not be_nil 
      end

      it "should assign @event" do
        Presenter.stub(:find).with("1") { mock_presenter }
        Event.stub(:find) { mock_presenter(:update_attributes => true) }
        do_update
        assigns(:event).should_not be_nil 
      end

      it "redirects to the presenter page" do
        Presenter.stub(:find) { mock_presenter(:update_attributes => true) }
        do_update
        response.should be_redirect
      end
    end

    context "with invalid params" do
    
      before (:each) do
        @presenter.stub(:update_attributes).and_return(false)
      end

      def do_update
        put :update, :event_id => 1, :id => "1", :parent_id => '50'
      end

      it "should load the requested presenter" do
        Presenter.stub(:find) { @presenter }
        do_update
      end

      it "should assign @presenter" do
        Presenter.stub(:find) { mock_presenter(:update_attributes => false) }
        do_update
        assigns(:presenter).should_not be_nil 
      end

      it "renders the edit form" do 
        Presenter.stub(:find) { mock_presenter(:update_attributes => false) }
        do_update
	response.should render_template(:edit)
      end
    end
  end

  describe "DELETE 'destroy'" do

    before (:each) do
      @presenter = stub_model(Presenter)
      Event.stub!(:find).and_return(@event)
      @event.stub!(:presenter).and_return(@presenter)
    end

    context 'success' do

      it "should load the requested presenter" do
        Presenter.stub(:find).with("37").and_return(@presenter)
      end

      it "destroys the requested presenter" do
        Presenter.stub(:find).with("37") { mock_presenter }
        mock_presenter.should_receive(:destroy)
        delete :destroy, :event_id => 1, :id => "37"
      end

      it "redirects to the presenters list" do
        Presenter.stub(:find) { mock_presenter }
        delete :destroy, :event_id => 1, :id => "1"
        response.should be_redirect
      end
    end

  end

end
