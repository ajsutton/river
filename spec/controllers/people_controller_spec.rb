require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  it 'should only list people from the current church' do
    church1 = create(:church)
    user1 = create(:user, church: church1)
    person1 = create(:person, church: church1)
    
    church2 = create(:church)
    person2 = create(:person, church: church2)
    
    get :index, {}, { 'user_id' => user1.id }
    expect(response).to have_http_status(:ok)
    expect(assigns(:people)).to eq([person1])
  end
end
