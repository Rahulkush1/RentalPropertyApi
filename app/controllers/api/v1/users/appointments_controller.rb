class Api::V1::Users::AppointmentsController < ApplicationController
	before_action :authenticate_user, :only => [:create, :index, :update, :destroy]
  	load_and_authorize_resource param_method: :appoinment_params

	def index
		if params["self_appointment"]
			render json: current_user.appointments ,status: :ok
		else
			render json: Appointment.joins(property: :user).where(user: {id: current_user.id}),status: :ok
		end
	end
	def create 
		@appointment = current_user.appointments.new(appoinment_params)
		if @appointment.save
			render json: @appointment, status: :created
		else
			render json: @appointment.errors.full_messages, status: :unprocessable_entity
		end
	end

	def update
		@appointment = Appointment.find(params[:id])
		@user =  User.find(Property.find(@appointment.property_id).user_id)
		if @user.id == current_user.id
			if appoinment_params[:status]
				 if @appointment.update(status: appoinment_params[:status])
				 	render json: @appointment, status: 202
				 else
				 	render json: {error: @appointment.errors.full_messages}, status: :unprocessable_entity
				 end
			elsif appoinment_params[:visit_status]
				if @appointment.update(visit_status: appoinment_params[:visit_status])
				 	render json: @appointment, status: 202
				else
				 	render json: {error: @appointment.errors.full_messages}, status: :unprocessable_entity
				end
			end
		else 
			render json: {error: "Not Authorized"}, status: :unauthorized
		end
	end

	def destroy 
		@appointment = Appointment.find(params[:id])
		@user =  User.find(Property.find(@appointment.property_id).user_id)
		if @user.id == current_user.id 
			if @appointment.destroy
				render json: {message: "appointment with id: #{@appointment.id} is deleted successfuly"},status: :see_other
			else
				render json: {error: @appointment.errors.full_messages}, status: :unprocessable_entity
			end
		else
			render json: {error: "Not Authorized"}, status: :unauthorized
		end
	end

	private
	 def appoinment_params

	 	params.require(:appointment).permit(:name, :email, :status, :visit_status, :phone, :date, :time, :property_id)
	 end
end
