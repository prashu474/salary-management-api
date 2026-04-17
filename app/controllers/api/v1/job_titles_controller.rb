class Api::V1::JobTitlesController < ApplicationController
  def index
    @job_titles = JobTitle.order(:category, :level, :title)
    render json: { data: @job_titles }
  end

  def show
    @job_title = JobTitle.find(params[:id])
    render json: { data: @job_title }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Job title not found' }, status: :not_found
  end
end
