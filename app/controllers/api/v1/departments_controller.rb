class Api::V1::DepartmentsController < ApplicationController
  def index
    @departments = Department.order(:name)
    render json: { data: @departments }
  end

  def show
    @department = Department.find(params[:id])
    render json: { data: @department }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Department not found' }, status: :not_found
  end
end
