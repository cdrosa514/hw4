class PlacesController < ApplicationController

  def index
    @places = Place.all

    respond_to do |format|
      format.html #{ render :template => "places/index" }
      format.json { render :json => @places }
    end


  def show
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
  @user = User.find_by({ "id" => session["user_id"] })
  if @user != nil
    @place = Place.new
    @place["name"] = params["name"]
    # @place["user_id"] = @user["id"]
    @place.save
   
  else
    flash["notice"] = "Login first."
  end
  redirect_to "/places"
end

  # before_action :allow_cors
  # def allow_cors
  #   response.headers['Access-Control-Allow-Origin'] = '*'
  #   response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
  #   response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
  #   response.headers['Access-Control-Max-Age'] = '1728000'
  # end
  
end
end