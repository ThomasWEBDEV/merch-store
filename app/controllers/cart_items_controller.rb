class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:product)
    @total = @cart_items.sum { |item| item.quantity * item.product.price }
  end

  def create
    @product = Product.find(params[:product_id])
    @cart_item = current_user.cart_items.find_or_initialize_by(product: @product)

    if @cart_item.persisted?
      @cart_item.quantity += 1
    else
      @cart_item.quantity = 1
    end

    if @cart_item.save
      redirect_to cart_items_path, notice: 'Produit ajouté au panier !'
    else
      redirect_to @product, alert: 'Erreur lors de l\'ajout au panier'
    end
  end

  def update
    @cart_item = current_user.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: 'Quantité mise à jour !'
    else
      redirect_to cart_items_path, alert: 'Erreur'
    end
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: 'Produit retiré du panier'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
