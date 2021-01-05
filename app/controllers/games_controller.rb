class GamesController < ApplicationController

    def index
        games = Game.all 
        render json: games
     end

     def new
        id = User.find_by("username": strong_params[:username]).id
        game = Game.create(strong_params[:score], id)
        # render json: game
     end


     private
    def strong_params
        params.permit(:username, :score)
    end
end
