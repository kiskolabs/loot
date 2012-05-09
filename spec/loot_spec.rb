require "spec_helper"

describe Loot do
  def app
    @app ||= Loot
  end

  describe "GET '/'" do
    it "should be successful" do
      get "/"
      last_response.should be_ok
    end
  end
end