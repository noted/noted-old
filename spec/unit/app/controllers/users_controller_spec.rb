require 'spec_helper'

describe 'Users' do
  let(:user) { create(:user) }

  describe 'GET /join' do
    before do
      get '/join'
    end

    it { response.should be_ok }
  end

  describe 'POST /users/create' do
    before do
      post '/users/create', :user => { :name => 'Carl Sagan', :email => 'carl@sagan.org', :username => 'carlsagan' }, :password => { :password => 'foobar', :confirm => 'foobar' }
    end

    it { response.should be_redirect }
    it { User.find_by_email('carl@sagan.org').should_not be_nil }
  end

  describe 'GET /settings' do
    before do
      get '/settings', {}, 'rack.session' => { :noted => user.id.to_s }
    end

    it { response.should be_ok }
  end

  describe 'PATCH /users/update' do
    before do
      patch '/users/update', :user => { :id => user.id, :name => 'Neil deGrasse Tyson' }

      user.reload
    end

    it { response.should be_redirect }
    it { response.location.should include '/settings' }
    it { user.name.should eql('Neil deGrasse Tyson') }
  end

  describe 'DELETE /users/destroy' do
    before do
      delete '/users/destroy', :user => { :id => user.id }
    end

    it { response.should be_redirect }
    it { response.location.should eql "#{site}/" }
    it { User.find_by_name('Neil deGrasse Tyson').should be_nil }
  end

  describe 'GET /:username' do
    before do
      get "/#{user.username}"
    end

    it { response.should be_ok }
  end
end
