class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :sales_user!, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order(id: 'DESC')
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
    @item = Item.find(params[:id])
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

  def sales_user!
    @item = Item.find(params[:id])
    redirect_to root_path unless @item.user_id == current_user.id
  end
end
