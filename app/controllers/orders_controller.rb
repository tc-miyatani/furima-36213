class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @pay_form = PayForm.new
  end

  def create
    @item = Item.find(params[:item_id])
    @pay_form = PayForm.new(pay_form_params)
    if @pay_form.valid? 
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
        :phone_number
      ).merge(
        item_id: params[:item_id],
        user_id: current_user.id
      )
  end
end
