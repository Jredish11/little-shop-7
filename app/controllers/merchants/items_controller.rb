class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])

    @disabled = Item.disabled_items
    @enabled = Item.enabled_items    
  end

  def new
    @item = Item.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    item = Item.new(item_params)
    merchant = Merchant.find(params[:merchant_id])

    if item.save
      flash[:notice] = "Item created successfully"
      redirect_to merchant_items_path(merchant)
    else
      flash[:alert] = "Item creation failed"
      redirect_to merchant_items_path(merchant)
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    if @item.update(item_params)
      redirect_to merchant_item_path(@merchant, @item)
      flash[:alert] = "Item updated successfully!"
    else
      redirect_to edit_merchant_item_path(@merchant, @item)
      flash[:alert] = "Error updating item, incomplete form"
    end
  end

  def status_update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if params[:commit] == "Enable" 
      @item.update(status: "enabled")
      flash[:notice] = "Item has been enabled"
    elsif params[:commit] == "Disable" 
      @item.update(status: "disabled")
      flash[:notice] = "Item has been disabled"
    end

    redirect_to merchant_items_path(@merchant)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :status)
  end
end