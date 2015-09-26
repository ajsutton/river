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
  
  it 'should not edit people from a different church' do
    get :edit, { id: @person2.id }, @session
    expect(response).to have_http_status(:not_found)
    expect(assigns(:person)).to be_nil
  end
end
