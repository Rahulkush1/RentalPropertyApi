require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do
  before(:each) do 
    @user = FactoryBot.create(:user)
    @token = JsonWebTokenService.encode({ id: @user.id })
    @req_params = request.headers.merge!("HTTP_AUTH_TOKEN" => "#{@token}")
  end

  describe "Post /create" do 
    let(:user_params) do {
      "user":{
        "email": "rahul@gmail.com",
         "password": "password"
      }
    }end
    it "Login User" do 
      post :create, params: user_params
      expect(response.status).to eq 200
    end
  end

  describe "Get /show" do 
    it " show user details" do 
      get :show, params: @req_params
      expect(response.status).to eq 200
    end
  end
end
