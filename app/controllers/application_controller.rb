class ApplicationController < ActionController::Base
	include AuthenticateHelper
	protect_from_forgery unless: -> { request.format.json? }

	rescue_from JWT::ExpiredSignature do |exception|
		render json: {message: "Please Login!"}
 	end
 	rescue_from ActiveRecord::RecordNotFound do |exception|
		render json: {message: exception.message}
 	end
 	
 	rescue_from JWT::DecodeError do |exception|
		render json: {message: exception.message}
 	end

 	rescue_from CanCan::AccessDenied do |exception|
		render json:  exception.message
 	end

 	rescue_from Twilio::REST::RestError do |exception|
		render json:  exception.message
 	end 

 	rescue_from ActiveRecord::RecordInvalid do |exception|
 		
 		render json: {message: exception.record.errors.full_messages}
 	end 
	
end

