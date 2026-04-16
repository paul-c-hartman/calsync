# typed: false

require 'rails_helper'

RSpec.describe "users/show" do
  let (:user) {
    create_user!
  }

  before do
    assign(:user, user)
  end

  it "renders attributes in <p>" do
    render
  end
end
