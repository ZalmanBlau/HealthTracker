require 'rails_helper'

RSpec.describe "UserSleeps", type: :request do
  describe "GET /user_sleeps" do
    it "works! (now write some real specs)" do
      get user_sleeps_path
      expect(response).to have_http_status(200)
    end
  end
end
