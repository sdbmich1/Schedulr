require File.dirname(__FILE__) + '/../spec_helper'

describe ManagePresentersController do

  def mock_event(stubs={})
    (@mock_event ||= mock_model(Event, stubs).as_null_object).tap do |event|
       event.stub(stubs) unless stubs.empty?
    end
  end

  def mock_event_presenter(stubs={})
    (@mock_event_presenter ||= mock_model(EventPresenter, stubs).as_null_object).tap do |presenter|
       presenter.stub(stubs) unless stubs.empty?
    end
  end

  before :each do
    @event = mock_model(Event) 
    @parent_event = stub_model(Event)
    Event.stub!(:find).and_return(@event)
    Event.stub!(:find).and_return(@parent_event)
    @event_presenter = stub_model(EventPresenter) 
    EventPresenter.stub(:new).and_return(@event_presenter)
  end

  describe "POST create" do

    def do_create
      post :create, :event_id => 1, :presenter_id => "23", :parent_id => "50"
    end

    context 'failure' do
      
      before :each do
        @event_presenter.stub!(:save).and_return(false)
      end

      it "should assign @event" do
        do_create
        assigns(:event).should_not be_nil 
      end

      it "should assign @event_presenter" do
        do_create
        assigns(:event_presenter).should_not be_nil 
      end

      it "should assign @event" do
        do_create
        assigns(:event).should_not be_nil 
      end

      it "should assign @parent_event" do
        do_create
        assigns(:parent_event).should_not be_nil 
      end

      it "should render the new template" do
        do_create
        response.should be_redirect
      end
    end

    context 'success' do

      it "should load the requested event presenter" do
        EventPresenter.stub(:new).with("23") { mock_event_presenter(:save => true) }
        do_create
      end

      it "should assign @event_presenter" do
        do_create
        assigns(:event_presenter).should_not be_nil 
      end

      it "should assign @event" do
        do_create
        assigns(:event).should_not be_nil 
      end

      it "should assign @parent_event" do
        do_create
        assigns(:parent_event).should_not be_nil 
      end

      it "should create @event_presenter relationship " do
        do_create
	response.should be_true
      end

      it "redirects to the parent event" do
        EventPresenter.stub(:new).with("23") { mock_event_presenter(:save => true) }
        do_create
        response.should be_redirect
      end

      it "should change event presenter count" do
        lambda do
          do_create
          should change(EventPresenter, :count).by(1)
        end
      end
    end
  end

  describe "DELETE 'destroy'" do

    before (:each) do
      @event = stub_model(Event) 
      EventPresenter.stub(:find_by_event_id_and_presenter_id).and_return(@event_presenter)
      @event_presenter.stub(:destroy).and_return(true)
    end

    def do_delete
      delete :destroy, :id => "37", :presenter_id => "1"
    end

    context 'success' do

      it "should load the requested event_presenter" do
        EventPresenter.stub(:find_by_event_id_and_presenter_id).with("37","1").and_return(@event_presenter)
        do_delete
      end

      it "destroys the requested event_presenter" do
        EventPresenter.stub(:find_by_event_id_and_presenter_id).with("37","1") { mock_event_presenter }
        mock_event_presenter.should_receive(:destroy)
        do_delete
      end

      it "redirects to the event_presenters list" do
        EventPresenter.stub(:find_by_event_id_and_presenter_id) { mock_event_presenter }
        do_delete
        response.should be_redirect
      end
    end

  end
end
