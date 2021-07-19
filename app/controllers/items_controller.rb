class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :sales_user!, only: [:edit, :update, :destroy]
  before_action :sold_out!, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes([:user, :order]).order(id: 'DESC')
  end

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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params
      .require(:item)
      .permit(
        :image, :name, :info,
        :category_id, :sales_status_id, :prefecture_id,
        :shipping_fee_status_id, :scheduled_delivery_id, :price
      ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def sales_user!
    redirect_to root_path unless @item.user_id == current_user.id
  end

  def sold_out!
    redirect_to root_path if @item.order.present?
  end
end
