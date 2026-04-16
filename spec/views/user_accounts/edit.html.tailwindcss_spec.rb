# typed: false

require 'rails_helper'

RSpec.describe "user_accounts/edit" do
  let(:user_account) {
    create_user_account!
  }

  before do
    assign(:user_account, user_account)
  end

  it "renders the edit user_account form" do
    render

    assert_select "form[action=?][method=?]", user_account_path(user_account), "post" do
    end
  end
end
