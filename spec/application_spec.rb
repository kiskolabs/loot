# encoding: UTF-8
require "spec_helper"

describe Loot do
  let(:app) { Loot::Application }

  describe "GET '/'" do
    it "should be successful" do
      get "/"
      last_response.should be_ok
    end
  end

  describe "POST '/amiando/:secret'" do
    it "should be successful if the secret is correct" do
      ENV["SECRET"] = "secret"

      flow = double("flow")
      flow.should_receive(:push_to_team_inbox).and_return(true)
      Flowdock::Flow.stub(:new).and_return(flow)

      post "/amiando/secret", params_for_one_ticket
      last_response.should be_ok
    end

    it "should be unsuccessful if the secret is incorrect" do
      ENV["SECRET"] = "secret"
      post "/amiando/wrongsecret", params_for_one_ticket
      last_response.should be_forbidden
    end
  end
end