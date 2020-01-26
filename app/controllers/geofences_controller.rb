class GeofencesController < ApplicationController

  before_action :set_geofence, only: [:show, :update, :destroy, :find_by_coordinate]

  # GET /geofences
  def index
    @geofences = Geofence.all

    render json: @geofences
  end

  # GET /geofences/1
  def show
    render json: @geofence
  end

  # POST /geofences
  def create
    @geofence = Geofence.new(geofence_params)
    if @geofence.save
      render json: @geofence, status: :created, location: @geofence
    else
      render json: @geofence.errors, status: :unprocessable_entity
    end
  end

  def find_by_coordinate
    target_coords = params[:target_coordinates]
    data = @geofence.find_target_coordinates target_coords
    if data.present?
      render json: @geofence 
    else
      render json: @geofence.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /geofences/1
  def update
    if @geofence.update(geofence_params)
      render json: @geofence
    else
      render json: @geofence.errors, status: :unprocessable_entity
    end
  end

  # DELETE /geofences/1
  def destroy
    @geofence.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geofence
      @geofence = Geofence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def geofence_params
      hash = {}
      hash[:area_name] =  params[:geofence][:area_name]
      hash[:coordinates] =  params[:geofence][:coordinates]
      hash
    end

    def set_params

    end
end
