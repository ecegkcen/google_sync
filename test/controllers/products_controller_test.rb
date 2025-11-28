require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = Product.create(name: "Test Ürün", price: 10.0, stock: 5, category: "Test")
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get show" do
    get product_url(@product)
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end
end