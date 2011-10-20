require File.dirname(__FILE__) + '/../spec_helper'

describe AdsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Ad.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Ad.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Ad.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(ad_url(assigns[:ad]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Ad.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Ad.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Ad.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Ad.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Ad.first
    response.should redirect_to(ad_url(assigns[:ad]))
  end

  it "destroy action should destroy model and redirect to index action" do
    ad = Ad.first
    delete :destroy, :id => ad
    response.should redirect_to(ads_url)
    Ad.exists?(ad.id).should be_false
  end
end
