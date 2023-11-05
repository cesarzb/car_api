module Api
  module V1
    class BrandsService
      attr_accessor :body, :status

      def initialize
        @body = nil
        @status = nil
      end

      def get_brand(id)
        if !set_brand
          @body = {error: "Couldn't find a brand with provided id"}
          @status = :not_found
        end

        @body = @brand
        @status = :ok
      end

      def get_brands
        @brands = Brand.all

        @body = @brands
        @status = :ok
      end

      def create_brand(brand_params)
        @brand = Brand.new(brand_params)

        @brand.save!

        @body = @brand
        @status = :created
      rescue ActiveRecord::RecordInvalid
        @body = @brand.errors
        @status = :unprocessable_entity
      end

      def update_brand(id, brand_params)
        if !set_brand
          @body = {error: "Couldn't find a brand with provided id"}
          @status = :not_found
        end

        @brand.update!(brand_params)

        @body = @brand
        @status = :ok
      rescue ActiveRecord::RecordInvalid
        @body = @brand.errors
        @status = :unprocessable_entity
      end

      def delete_brand(id)
        if !set_brand
          @body = {error: "Couldn't find a brand with provided id"}
          @status = :not_found
        end

        @brand.destroy!
        @body = nil
        @status = :ok
      rescue ActiveRecord::RecordNotDestroyed
        @body = { error: "Couldn't destroy the brand"}
        @status = :unprocessable_entity
      end

      private

      def set_brand
        @brand = Brand.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          return false
      end
    end
  end
end
