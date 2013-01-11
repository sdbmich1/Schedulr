require File.dirname(__FILE__) + '/../spec_helper'

describe Exhibitor do
  before(:each) do
    @exhibitor = Factory.build :exhibitor
    @newexhibitor = Factory.create :exhibitor
  end

  it "should be valid" do
    @exhibitor.name = 'Test Name'
    @exhibitor.description = 'Test'
    @exhibitor.should be_valid
  end

  describe "name validations" do

    it "should have an exhibitor name" do
      @exhibitor.name = 'Test'
      @exhibitor.should be_valid
    end

    it "should reject invalid exhibitor name" do
      names = %w[user@foo,com user=_at_foo.org @@4$$?? example.user@foo.]
      names.each do |name|
        @exhibitor.name = name
        @exhibitor.should_not be_valid
      end
    end

    it "should not be valid without exhibitor name" do
      @exhibitor.name = nil
      @exhibitor.should_not be_valid
    end

    it "should reject duplicate exhibitor name" do
      @attr = {:name => 'Test', :description => 'Stuff'}
      Exhibitor.create!(@attr)
      dup_exhibitor = Exhibitor.new(@attr)
      dup_exhibitor.should_not be_valid
    end
  end

  describe "description validations" do

    it "should have an exhibitor description" do
      @exhibitor.name = 'Test Name'
      @exhibitor.description = 'Test'
      @exhibitor.should be_valid
    end

    it "should not be valid without exhibitor description" do
      @exhibitor.description = nil
      @exhibitor.should_not be_valid
    end
  end

  describe 'event_exhibitors' do
    
    it "should have a event_exhibitors method" do
      @exhibitor.should respond_to(:event_exhibitors)
    end
  end

  describe 'events' do
    
    it "should have an events method" do
      @exhibitor.should respond_to(:events)
    end
  end

  describe 'pictures' do
    
    before(:each) do
      @sr = @newexhibitor.pictures.create Factory.attributes_for(:picture)
    end

    it "should have a pictures method" do
      @exhibitor.should respond_to(:pictures)
    end

    it "has many pictures" do
      @newexhibitor.pictures.should include(@sr)
    end

    it "should destroy associated pictures" do
      @newexhibitor.destroy
      [@sr].each do |s|
        Picture.find_by_id(s.id).should be_nil
      end
    end
  end

  describe 'contact_details' do
    
    before(:each) do
      @sr = @newexhibitor.contact_details.create Factory.attributes_for(:contact_detail)
    end

    it "should have a contact_details method" do
      @exhibitor.should respond_to(:contact_details)
    end

    it "has many contact_details" do
      @newexhibitor.contact_details.should include(@sr)
    end

    it "should destroy associated contact_details" do
      @newexhibitor.destroy
      [@sr].each do |s|
        ContactDetail.find_by_id(s.id).should be_nil
      end
    end
  end
end
