require 'spec_helper'

describe "Projects" do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  describe "GET /:username/:project" do
    before do
      get "/#{project.url}"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "GET /projects/new" do
    before do
      get "/projects/new"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "POST /projects/create" do
    before do
      post "/projects/create", :author => user.id, :project => { :title => "The Hubble Telescope" }
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{user.username}/the-hubble-telescope") }
    end

    it { Project.find_by_title("The Hubble Telescope").should_not be_nil }
    it { user.projects.should include(Project.find_by_title("The Hubble Telescope")) }
  end

  describe "GET /:username/:project/settings" do
    before do
      get "/#{user.username}/#{project.permalink}/settings"
    end

    it "is ok" do
      response.should be_ok
    end
  end

  describe "PATCH /projects/update" do
    before do
      patch "/projects/update", :id => project.id, :project => { :title => "Large Hadron Collider" }

      project.reload
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("#{project.user.username}/#{project.permalink}/settings") }
    end

    it { project.title.should eql("Large Hadron Collider") }
  end

  describe "DELETE /projects/destroy" do
    before do
      delete "/projects/destroy", :id => project.id, :author => user.id
    end

    context "redirects" do
      it { response.should be_redirect }
      it { response.location.should include("/#{project.user.username}") }
    end

    it { Project.find_by_name("The Cosmos").should be_nil }
  end
end