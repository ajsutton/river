require 'rails_helper'

describe Church, type: :model do
  it 'should have a valid factory' do
    expect(create(:church)).to be_valid
  end
  
  it 'requires a unique shortname' do
    create(:church, shortname: 'church1');
    expect(build(:church, shortname: 'church1')).to be_invalid
  end
  
  it 'only allows letters and numbers in short name' do
    expect(build(:church, shortname: 'the church')).to be_invalid
  end
  
  it 'only allows 16 characters in short name' do
    expect(build(:church, shortname: "x" * 16)).to be_valid
    expect(build(:church, shortname: "x" * 17)).to be_invalid
  end
  
  it 'requires name' do
    expect(build(:church, name: nil)).to be_invalid
  end
end
