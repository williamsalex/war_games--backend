class UsersController < ApplicationController
    def index
        users = User.all 
        render json: users
     end
 
     def show
         user = User.find_by(id: params[:id])
         render json: user
     end

     def login
        user = User.find_or_create_by(id: params[:id])
         render json: user
     end

     def new
        user = User.find_or_create_by(strong_params)
     end

     private
    def strong_params
        params.permit(:username)
    end

end
