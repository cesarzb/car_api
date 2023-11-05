module Api
  module V1
    class BrandsService
      attr_accessor :body, :status

      def initialize
        @body = nil
        @status = nil
      end

      def get_brand(id)
        if !set_brand(id)
          @body = {error: "Couldn't find a brand with provided id"}
          @status = :not_found
        end

        @body = @brand
        @status = :ok
      end

      def get_brands(page)
        per_page = 5 # Number of cars per page
        offset = (page - 1) * per_page

        @brands = Brand.limit(per_page).offset(offset)

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
        if !set_brand(id)
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
        if !set_brand(id)
          @body = {error: "Couldn't find a brand with provided id"}
          @status = :not_found
        end

        @brand.destroy!
        @body = nil
        @status = :ok
      rescue ActiveRecord::RecordNotDestroyed
        @body = { error: "Couldn't destroy the brand"}
        @status = :unprocessable_entity
      rescue ActiveRecord::InvalidForeignKey
        @body = { error: "Couldn't destroy the brand because some cars reference it"}
        @status = :unprocessable_entity
      end

      private

      def set_brand(id)
        @brand = Brand.find(id)
        rescue ActiveRecord::RecordNotFound
          return false
      end
    end
  end
end
