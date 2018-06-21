require 'rails_helper'

RSpec.describe Customer, type: :model do

  before { @customer = customers(:acme) }

  context "associations" do
    it 'should have many users' do
      expect(@customer.users).to include(users(:active_user))
    end

    it 'should handle deleting by nullifying associated users' do
      expect {
        @customer.destroy
      }.to change(Customer, :count).by(-1)
      expect(users(:active_user).customer.blank?).to be_truthy
    end
  end

  context "validations" do
    it 'should be valid' do
      expect(@customer.valid?).to be_truthy
    end

    it 'should be invalid without name' do
      @customer.name = nil
      expect(@customer.valid?).to be_falsey
      expect(@customer.errors[:name].first).to eq("can't be blank")
    end

    it 'should be invalid with name smaller then 3 characters' do
      @customer.name = 'ab'
      expect(@customer.valid?).to be_falsey
      expect(@customer.errors[:name].first).to eq('is too short (minimum is 3 characters)')
    end

    it 'should be invalid with name longer then 50 characters' do
      @customer.name = 'a'*51
      expect(@customer.valid?).to be_falsey
      expect(@customer.errors[:name].first).to eq('is too long (maximum is 50 characters)')
    end

    it 'should be invalid if name already taken' do
      @customer.name = customers(:hooli).name
      expect(@customer.valid?).to be_falsey
      expect(@customer.errors[:name].first).to eq('has already been taken')
    end

    it 'should be invalid without active' do
      @customer.active = nil
      expect(@customer.valid?).to be_falsey
      expect(@customer.errors[:active].first).to eq('must be true or false')
    end
  end
end
