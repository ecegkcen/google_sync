class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Ürün başarıyla oluşturuldu."
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: "Ürün başarıyla güncellendi."
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Ürün silindi."
  end

  # Google Sheet import action
  def import_from_sheet
    GoogleSheetsImportService.new.import_products_from_sheet
    redirect_to products_path, notice: "✅ Google Sheet'ten ürünler güncellendi!"
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :stock, :category)
  end
end
