# typed: false

require 'rails_helper'

RSpec.describe "Sessions" do
  describe "GET /login" do
    it "returns http success" do
      get "/sessions/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /failure" do
    it "returns http success" do
      get "/sessions/failure"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/sessions/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
