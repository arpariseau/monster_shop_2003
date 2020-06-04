class Merchant::ItemsController < ApplicationController
  before_action :require_merchant_employee

  def index
    @merchant = current_user.merchant
    @items = current_user.merchant.items
  end

  def update
    @item = Item.find(params[:id])
    if !params[:active?].nil? && (params[:active?] == "true")
      flash[:success] = "#{@item.name} is now available for sale"
      @item.update(item_params)
    elsif !params[:active?].nil? && (params[:active?] == "false")
      flash[:success] = "#{@item.name} is no longer for sale"
      @item.update(item_params)
    elsif @item.update(item_params)
      flash[:success] = "#{@item.name} is updated"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :edit
    end
    redirect_to merchant_items_path
  end

  def destroy
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    flash[:success] = "#{item.name} is now deleted"
    redirect_to merchant_items_path
  end

  def new

  end

  def create
    merchant = current_user.merchant
    item = merchant.items.create(item_params)
    if item.save
      flash[:success] = "#{item.name} is saved"
      redirect_to merchant_items_path
    else
      flash[:error] = item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.permit(:name, :description, :price, :inventory, :image, :active?)
  end
end
