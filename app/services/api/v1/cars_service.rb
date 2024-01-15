module Api
  module V1
    class CarsService
      attr_accessor :body, :status

      def initialize
        @body = nil
        @status = nil
      end

      def get_car(id)
        if !set_car(id)
          @body = {error: "Couldn't find a car with provided id"}
          @status = :not_found
        end

        @body = @car
        @status = :ok
      end

      def get_cars(page)
        per_page = 12 # Number of cars per page
        offset = (page - 1) * per_page

        @cars = Car.limit(per_page).offset(offset)

        @body = @cars
        @status = :ok
      end

      def create_car(car_params, brand_name)
        @car = Car.new(car_params)
        @brand = Brand.find_by(name: brand_name)

        @car.brand = @brand
        @car.save!

        @body = @car
        @status = :created
      rescue ActiveRecord::RecordInvalid
        @body = @car.errors
        @status = :unprocessable_entity
      rescue ActiveRecord::RecordNotFound
        @car.errors << {brand: ["must exist"]}
        @body = @car.errors
        @status = :unprocessable_entity
      end

      def update_car(id, car_params, brand_name)
        if !set_car(id)
          @body = {error: "Couldn't find a car with provided id"}
          @status = :not_found
        end
        @brand = Brand.find_by(name: brand_name)

        @car.brand = @brand
        @car.update!(car_params)

        @body = @car
        @status = :ok
      rescue ActiveRecord::RecordInvalid
        @body = @car.errors
        @status = :unprocessable_entity
      rescue ActiveRecord::RecordNotFound
        @car.errors << {brand: ["must exist"]}
        @body = @car.errors
        @status = :unprocessable_entity
      end

      def delete_car(id)
        if !set_car(id)
          @body = {error: "Couldn't find a car with provided id"}
          @status = :not_found
        end

        @car.destroy!
        @body = nil
        @status = :ok
      rescue ActiveRecord::RecordNotDestroyed
        @body = { error: "Couldn't destroy the car"}
        @status = :unprocessable_entity
      end

      private

      def set_car(id)
        @car = Car.find(id)
        rescue ActiveRecord::RecordNotFound
          return false
      end
    end
  end
end
