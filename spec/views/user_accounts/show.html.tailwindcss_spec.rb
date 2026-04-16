# typed: false

require 'rails_helper'

RSpec.describe "user_accounts/show" do
  let (:user_account) {
    create_user_account!
  }

  before do
    assign(:user_account, user_account)
  end

  it "renders attributes in <p>" do
    render
  end
end
