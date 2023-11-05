module Api
  module V1
    class BrandsController < ApplicationController
    # GET /brands
    def index
      brands_service = Api::V1::BrandsService.new
      page = params[:page].to_i || 1
      brands_service.get_brands(page)

      render json: brands_service.body, status: brands_service.status
    end

    # GET /brands/1
    def show
      brands_service = Api::V1::BrandsService.new
      brands_service.get_brand(params[:id])

      render json: brands_service.body, status: brands_service.status
    end

    # POST /brands
    def create
      brands_service = Api::V1::BrandsService.new
      brands_service.create_brand(brand_params)

      render json: brands_service.body, status: brands_service.status, location: api_v1_brand_url(brands_service.body)
    end

    # PATCH/PUT /brands/1
    def update
      brands_service = Api::V1::BrandsService.new
      brands_service.update_brand(params[:id], brand_params)

      render json: brands_service.body, status: brands_service.status
    end

    # DELETE /brands/1
    def destroy
      brands_service = Api::V1::BrandsService.new
      brands_service.delete_brand(params[:id])

      render json: brands_service.body, status: brands_service.status
    end

    private

        # Only allow a list of trusted parameters through.
        def brand_params
          params.require(:brand).permit(:name, :year)
        end
    end
  end
end
