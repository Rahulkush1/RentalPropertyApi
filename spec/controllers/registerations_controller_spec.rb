require 'rails_helper'

RSpec.describe Api::V1::Users::RegisterationsController, type: :controller do
  before(:each) do 
  	@role = FactoryBot.create(:role, name: "admin")
  	@role2 = FactoryBot.create(:role, name: "buyer")
  	@role3 = FactoryBot.create(:role, name: "broker")
  	@user = FactoryBot.create(:user)
  	@token = JsonWebTokenService.encode({ id: @user.id })
    @req_params = request.headers.merge!("HTTP_AUTH_TOKEN" => "#{@token}")
  end

    let(:user_params) do {
      "user":{
		"email": "rahul1@gmail.com",
		"password": "password",
		"firts_name": "rahul",
		"last_name": "kushwaha",
		"role_ids": [@role]
      }
    }end
  describe "Post /create" do 
    it "Register User" do 
      post :create, params: user_params
      expect(response.status).to eq 201
    end
  end

  describe "Put  /update" do 
  	it "Update User Details" do 
  		put :update, params: @req_params.merge(id: @user.id, user: user_params)
  		expect(response.status).to eq 200
  	end
  end

  describe "Get /email_confirm" do 
  	it " email confirmation" do 
  		get :email_confirm, params: { token: @token,}
  		expect(response.status).to eq 200
  	end
  end

end
