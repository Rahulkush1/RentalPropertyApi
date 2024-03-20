class Api::V1::ReviewsController < ApplicationController
	  before_action :authenticate_user, :only => [:create]

	def create
		@review = Review.find_by(user_id: current_user.id, reviewable_id: params[:property_id])
		@property = Property.find(params[:property_id])
		if @review
			if @property.reviews.update(review_params)
				render json: ReviewSerializer.new(@review).serialized_json, status: :ok
			else
			render json: @review.erorrs, status: :unprocessable_entity
			end
		else
			@review = @property.reviews.new(review_params.merge(user_id: current_user.id))
			if @review.save
				render json: ReviewSerializer.new(@review).serialized_json, status: :created
			else
				render json: @review.erorrs, status: :unprocessable_entity
			end
		end
	end

	def show

	end

	private

	def review_params
		params.require(:review).permit(:review, :rating)
	end
end