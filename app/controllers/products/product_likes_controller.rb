module Products
  class ProductLikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_product

    def create
      @product_like = @product.product_likes.new(user: Current.user, rating: params[:rating])

      if @product_like.save
        render json: { message: "Like added successfully" }, status: :created
      else
        render json: { errors: @product_like.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

      def set_product
        @product = Product.find(params[:product_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Product not found" }, status: :not_found
      end
  end
end
