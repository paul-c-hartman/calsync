# typed: false

require "rails_helper"

RSpec.describe FlowFiltersController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/flow_filters").to route_to("flow_filters#index")
    end

    it "routes to #new" do
      expect(get: "/flow_filters/new").to route_to("flow_filters#new")
    end

    it "routes to #show" do
      expect(get: "/flow_filters/1").to route_to("flow_filters#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/flow_filters/1/edit").to route_to("flow_filters#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/flow_filters").to route_to("flow_filters#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/flow_filters/1").to route_to("flow_filters#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/flow_filters/1").to route_to("flow_filters#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/flow_filters/1").to route_to("flow_filters#destroy", id: "1")
    end
  end
end
