require 'rails_helper'

describe SitesController, 'html' do
  before { login_as :admin }

  it 'handles / with GET' do
    gt :sites
    expect(response).to be_successful
  end

  it 'handles /sites with valid parameters and POST' do
    expect {
      pst :sites, site: { url: 'https://google.com' }
      expect(assigns(:site).user).to eq(@user)
      expect(response).to redirect_to(sites_path)
    }.to change(Site, :count).by(1)
  end

  it 'handles /sites with invalid url and POST' do
    expect {
      pst :sites, site: { url: 'invalid' }
      expect(response).to be_successful
      expect(response).to render_template(:index)
    }.not_to change(Site, :count)
  end

  it 'handles /sites with active customer' do
    login_as :active_user

    expect {
      pst :sites, site: { url: 'https://google.com' }
      expect(assigns(:site).user).to eq(@user)
      expect(response).to redirect_to(sites_path)
    }.to change(Site, :count).by(1)
  end

  it 'handles /sites with inactive customer' do
    login_as :cancelled_user

    expect {
      pst :sites, site: { url: 'https://google.com' }
      expect(response).to be_successful
      expect(response).to render_template(:index)
    }.not_to change(Site, :count)
  end
end

describe SitesController, 'js api' do
  before { login_as :admin }

  it 'handles / with valid parameters and POST' do
    expect {
      pst :sites, site: { url: 'https://google.com' }, format: :json
      expect(assigns(:site).user).to eq(@user)
      expect(response).to be_successful
      expect(response.body).to be_include('"status":"succeeded"')
    }.to change(Site, :count).by(1)
  end

  it 'handles / with empty url and POST' do
    expect {
      pst :sites, format: :json
      expect(response).to be_successful
      expect(response.body).to be_include(':{"errors":{"url":["is invalid"]}}')
    }.not_to change(Site, :count)
  end

  it 'handles /sites with invalid url and POST' do
    expect {
      pst :sites, site: { url: 'invalid' }, format: :json
      expect(response).to be_successful
      expect(response.body).to be_include(':{"errors":{"url":["is invalid"]}}')
    }.not_to change(Site, :count)
  end

  it 'handles /sites with active customer' do
    login_as :active_user

    expect {
      pst :sites, site: { url: 'https://google.com' }, format: :json
      expect(assigns(:site).user).to eq(@user)
      expect(response).to be_successful
      expect(response.body).to be_include('"status":"succeeded"')
    }.to change(Site, :count).by(1)
  end

  it 'handles /sites with inactive customer' do
    login_as :cancelled_user

    expect {
      pst :sites, site: { url: 'https://google.com' }, format: :json
      expect(response).to be_successful
      expect(response.body).to be_include(':{"errors":{"user":["is an inactive customer. Only active customers may take site captures."]}}')
    }.not_to change(Site, :count)
  end

end
