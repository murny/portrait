require 'rails_helper'

RSpec.describe CustomersController do
  before { login_as :admin }

  it 'handles /customers with GET' do
    gt :customers
    expect(response).to be_successful
  end

  it 'handles /customers/:id with GET' do
    gt customers(:acme)
    expect(response).to be_successful
  end

  it 'handles /customers with valid params and POST' do
    expect {
      pst :customers, customer: { name: 'Cool Company LLC' }
      expect(response).to redirect_to(customers_path)
    }.to change(Customer, :count).by(1)
  end

  it 'handles /customers/:id with valid params and PUT' do
    customer = customers(:acme)
    ptch customer, customer: { name: 'new name inc' }
    expect(customer.reload.name).to eq('new name inc')
    expect(response).to redirect_to(customer_path(customer))
  end

  it 'handles /customers/:id with invalid params and PUT' do
    customer = customers(:acme)
    ptch customer, customer: { name: '' }
    expect(customer.reload.name).not_to be_blank
    expect(response).to be_successful
    expect(response).to render_template(:show)
  end

  it 'handles /customers/:id with DELETE' do
    expect {
      del customers(:acme)
      expect(response).to redirect_to(customers_path)
    }.to change(Customer, :count).by(-1)
  end
end
