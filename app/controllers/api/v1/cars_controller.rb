module Api
  module V1
    class CarsController < ApplicationController
      # GET /cars
      def index
        cars_service = Api::V1::CarsService.new
        page = params[:page].to_i || 1
        cars_service.get_cars(page)

        render json: cars_service.body.to_json, status: cars_service.status
      end

      # GET /cars/1
      def show
        cars_service = Api::V1::CarsService.new
        cars_service.get_car(params[:id])

        render json: cars_service.body.to_json, status: cars_service.status
      end

      # POST /cars
      def create
        cars_service = Api::V1::CarsService.new
        cars_service.create_car(car_params, params[:car][:brand_name])

        render json: cars_service.body.to_json, status: cars_service.status, location: api_v1_car_url(cars_service.body)
      end

      # PATCH/PUT /cars/1
      def update
        cars_service = Api::V1::CarsService.new
        cars_service.update_car(params[:id], car_params, params[:car][:brand_name])

        render json: cars_service.body.to_json, status: cars_service.status
      end

      # DELETE /cars/1
      def destroy
        cars_service = Api::V1::CarsService.new
        cars_service.delete_car(params[:id])

        render json: cars_service.body.to_json, status: cars_service.status
      end

      private
        # Only allow a list of trusted parameters through.
        def car_params
          params.require(:car).permit(:seats, :model, :price)
        end
    end
  end
end
