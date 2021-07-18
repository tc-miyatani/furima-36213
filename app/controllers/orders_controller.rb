class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :buyable!

  def index
    @pay_form = PayForm.new
  end

  def create
    @pay_form = PayForm.new(pay_form_params)
    if @pay_form.valid? 
      pay_item
      @pay_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def pay_form_params
    params
      .require(:pay_form)
      .permit(
        :postal_code, :prefecture_id,
        :city, :addresses, :building,
        :phone_number, :token
      ).merge(
        item_id: params[:item_id],
        user_id: current_user.id
      )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: @pay_form.token,
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def buyable!
    redirect_to root_path if @item.user_id == current_user.id || @item.order.present? 
  end
end
