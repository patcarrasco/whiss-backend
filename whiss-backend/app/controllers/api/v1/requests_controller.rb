class Api::V1::RequestsController < ApplicationController
	include Response
	def index
		json_response Request.all
	end
	def show
		json_response Request.find(params[:id])
	end
	def create
		new_request = Request.new(sender_id: params[:sender_id], receiver_id: params[:receiver_id])
		if new_request.save
			json_response new_request
		else
			json_response "Create -> Already Exists"
		end
	end
	def approve
		request = Request.find(params[:id])
		if Friendship.between(request.sender_id, request.receiver_id).empty? 
      friendship = Friendship.create(friend1_id: request.sender_id, friend2_id: request.receiver_id)
			request.update(approved: true)
			json_response friendship
		else
			json_response "Approve -> Already Exists"
    end 
	end
	def destroy
		request = Request.find(params[:id])
		request.destroy
		json_response "Destroyed"
	end
end
