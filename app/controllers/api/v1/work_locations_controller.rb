class Api::V1::WorkLocationsController < ApplicationController
  def index
    @work_locations = WorkLocation.order(:country_name, :city)
    render json: { data: @work_locations }
  end

  def show
    @work_location = WorkLocation.find(params[:id])
    render json: { data: @work_location }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Work location not found' }, status: :not_found
  end
end
