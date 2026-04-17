require 'rails_helper'

RSpec.describe "Api::V1::Insights", type: :request do
  describe "GET /salary_by_country" do
    it "returns http success" do
      get "/api/v1/insights/salary_by_country"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /salary_by_job_title" do
    it "returns http success" do
      get "/api/v1/insights/salary_by_job_title"
      expect(response).to have_http_status(:success)
    end
  end

end
