# typed: false

require "rails_helper"

RSpec.describe FlowTransformsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/flow_transforms").to route_to("flow_transforms#index")
    end

    it "routes to #new" do
      expect(get: "/flow_transforms/new").to route_to("flow_transforms#new")
    end

    it "routes to #show" do
      expect(get: "/flow_transforms/1").to route_to("flow_transforms#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/flow_transforms/1/edit").to route_to("flow_transforms#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/flow_transforms").to route_to("flow_transforms#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/flow_transforms/1").to route_to("flow_transforms#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/flow_transforms/1").to route_to("flow_transforms#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/flow_transforms/1").to route_to("flow_transforms#destroy", id: "1")
    end
  end
end
