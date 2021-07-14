class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item)
      .permit(
        :image, :name, :info,
        :category_id, :sales_status_id, :prefecture_id,
        :shipping_fee_status_id, :scheduled_delivery_id, :price
      ).merge(user_id: current_user.id)
  end
end
