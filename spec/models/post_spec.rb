# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:likes). dependent(:destroy) }
    it { should have_many(:comments). dependent(:destroy) }
  end
end