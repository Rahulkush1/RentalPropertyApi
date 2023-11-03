require 'rails_helper'

RSpec.describe Api::V1::Users::AppointmentsController, type: :controller do
  before(:each) do 
    @user = FactoryBot.create(:user)
    @property = FactoryBot.create(:property, user_id: @user.id)
    @appointment = FactoryBot.create(:appointment, user_id: @user.id, property_id: @property.id)
  	@token = JsonWebTokenService.encode({ id: @user.id })
    @req_params = request.headers.merge!("HTTP_AUTH_TOKEN" => "#{@token}")
  end

  describe "GET /index" do 
  	it "get self  appointments" do 
  		get :index, params: @req_params.merge!(self_appointment: true)
  		expect(response.status).to eq 200
  	end

  	it "get owner or broker  appointments" do 
  		get :index, params: @req_params
  		expect(response.status).to eq 200
  	end
  end

  let(:appointment_params) do {
  		"status": "approved"
  }end

  let(:appointment_req_params) do {
  	"name": "fghj",
  	"property_id": @property.id ,
    "email": "rahulkush2023@gmail.com",
    "phone": 99656856669,
    "date": "2023-11-21",
    "time": "04:10" 
  }end 

  describe "PUT /update" do 
  	it "update appointment status" do 
  		put :update, params: @req_params.merge!(id: @appointment.id,appointment: appointment_params)
  		expect(response.status).to eq 202
  	end

  	it "update appointment visit_status" do 
  		put :update, params: @req_params.merge!(id: @appointment.id,appointment: {"visit_status": "visit_approved"})
  		expect(response.status).to eq 202
  	end
  end

  describe "POST /create" do 
  	it "Create Appointment" do 
  		post :create , params: @req_params.merge!(appointment: appointment_req_params)
  		expect(response.status).to eq 201
  	end
  end

  describe "Delete /destroy" do 
  	it "Delete Appointment" do 
  		delete :destroy, params: @req_params.merge!(id: @appointment.id)
  		expect(response.status).to eq 303
  	end
  end

end