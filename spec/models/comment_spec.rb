# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
      expect(create(:comment)).to be_valid
  end
end
