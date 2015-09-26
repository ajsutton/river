require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  before :each do
    @church1 = create(:church)
    @user1 = create(:user, church: @church1)
    @person1 = create(:person, church: @church1)

    @church2 = create(:church)
    @person2 = create(:person, church: @church2)
    
    @session = { 'user_id' => @user1.id }
  end
  
  it 'should only list people from the current church' do
    get :index, {}, @session
    expect(response).to have_http_status(:ok)
    expect(assigns(:people)).to eq([@person1])
  end
  
  describe 'edit' do
    it 'should not edit people from a different church' do
      get :edit, { id: @person2.id }, @session
      expect(response).to have_http_status(:not_found)
      expect(assigns(:person)).to be_nil
    end
    
    it 'should edit people from the current church' do
      get :edit, { id: @person1.id }, @session
      expect(response).to have_http_status(:ok)
      expect(assigns(:person)).to eq(@person1)
    end
  end
  
  describe 'update' do
    it 'should not update people from a different church' do
      put :update, { id: @person2.id, person: attributes_for(:person, first_name: 'Foo') }, @session
      expect(response).to have_http_status(:not_found)
      expect(Person.find(@person2.id).first_name).to eq(@person2.first_name)
    end
  
    it 'should update people in the current church' do
      put :update, { id: @person1.id, person: attributes_for(:person, first_name: 'Foo') }, @session
      expect(response).to redirect_to(people_path)
      expect(Person.find(@person1.id).first_name).to eq('Foo')
    end
  end
end
