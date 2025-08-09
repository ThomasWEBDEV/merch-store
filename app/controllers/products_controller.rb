class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Produit créé avec succès !'
    else
      render :new
    end
  end

  def edit
    unless @product.user == current_user
      redirect_to products_path, alert: 'Non autorisé'
    end
  end

  def update
    if @product.user == current_user && @product.update(product_params)
      redirect_to @product, notice: 'Produit mis à jour !'
    else
      render :edit
    end
  end

  def destroy
    if @product.user == current_user
      @product.destroy
      redirect_to products_path, notice: 'Produit supprimé !'
    else
      redirect_to products_path, alert: 'Non autorisé'
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end
