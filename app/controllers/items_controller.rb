class ItemsController < ApplicationController
  def create
    header = request.headers["Authorization"]

    if !header
      render json: { error: "No Token Present" }, status: :unauthorized
    else
      begin
        token = header.split(" ")[1]
        secret = Rails.application.secret_key_base
        payload = JWT.decode(token, secret)[0]

        @user = User.find payload["user_id"]
        
        @item = Item.create({
          name: params[:name],
          price: params[:price]
        })
        
        render json: { item: @item }
      rescue
        render json: { error: "Bad Token" }, status: :unauthorized
      end
    end

  end
  def index
    @items = Item.all

    render json: { items: @items }
  end
end
