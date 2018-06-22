require 'rails_helper'

RSpec.describe Tier, type: :model do
  before { @tier = tiers(:basic) }

  context "associations" do
    it 'should have many customers' do
      expect(@tier.customers).to include(customers(:acme))
    end

    it 'should handle deleting by nullifying associated customers' do
      expect {
        @tier.destroy
      }.to change(Tier, :count).by(-1)
      expect(customers(:acme).tier.blank?).to be_truthy
    end
  end

  context "validations" do
    it 'should be valid' do
      expect(@tier.valid?).to be_truthy
    end

    it 'should be invalid without name' do
      @tier.name = nil
      expect(@tier.valid?).to be_falsey
      expect(@tier.errors[:name].first).to eq("can't be blank")
    end

    it 'should be invalid without quantity' do
      @tier.quantity = nil
      expect(@tier.valid?).to be_falsey
      expect(@tier.errors[:quantity].first).to eq("can't be blank")
    end

    it 'should be invalid with quantity lower then 0' do
      @tier.quantity = -100
      expect(@tier.valid?).to be_falsey
      expect(@tier.errors[:quantity].first).to eq('must be greater than or equal to 0')
    end

    it 'should be invalid with non-integer quantity' do
      @tier.quantity = 100.5
      expect(@tier.valid?).to be_falsey
      expect(@tier.errors[:quantity].first).to eq('must be an integer')
    end

    it 'should be invalid without price' do
      @tier.price = nil
      expect(@tier.valid?).to be_falsey
      expect(@tier.errors[:price].first).to eq("can't be blank")
    end

    it 'should be invalid with price lower then 0' do
      @tier.price = -1.0
      expect(@tier.valid?).to be_falsey
      expect(@tier.errors[:price].first).to eq('must be greater than or equal to 0')
    end

    it 'should be invalid with price greater then 100 million' do
      @tier.price = 100_000_000
      expect(@tier.valid?).to be_falsey
      expect(@tier.errors[:price].first).to eq('must be less than or equal to 99999999.99')
    end
  end
end
