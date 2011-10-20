require File.dirname(__FILE__) + '/../spec_helper'

describe SponsorsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Sponsor.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Sponsor.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Sponsor.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(sponsor_url(assigns[:sponsor]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Sponsor.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Sponsor.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Sponsor.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Sponsor.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Sponsor.first
    response.should redirect_to(sponsor_url(assigns[:sponsor]))
  end

  it "destroy action should destroy model and redirect to index action" do
    sponsor = Sponsor.first
    delete :destroy, :id => sponsor
    response.should redirect_to(sponsors_url)
    Sponsor.exists?(sponsor.id).should be_false
  end
end
