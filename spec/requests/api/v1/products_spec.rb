require "rails_helper"

RSpec.describe "Products", type: :request do

  let(:product) { create(:public_product) }
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  describe "GET /api/v1/products" do
    context "right count" do
      before do
        create_list(:public_product, 3, category: category)
      end

      it "without params" do
        get "/api/v1/products"

        result = JSON.parse(response.body)
        expect(result["products"].size).to eq 3
      end

      context "with category_name params" do
        before do
          @iphone_products = create_list(:public_product, 3, category: create(:category, name: "iPhone"))
          @mac_products = create_list(:mac_product, 2, category: create(:category, name: "Mac"))
        end

        it "when category is iPhone" do
          get "/api/v1/products", params: { category_name: "iPhone" }

          result = JSON.parse(response.body)
          expect(result["products"].size).to eq @iphone_products.size
        end

        it "when category is Mac" do
          get "/api/v1/products", params: { category_name: "Mac" }

          result = JSON.parse(response.body)
          expect(result["products"].size).to eq @mac_products.size
        end
      end

      it "filter hidden products" do
        create(:hidden_product)
        get "/api/v1/products"

        result = JSON.parse(response.body)
        expect(result["products"].size).to eq 3
      end
    end

    it "paged" do
      create_list(:public_product, 5)

      get "/api/v1/products", params: { page: 3, per_page: 2 }

      result = JSON.parse(response.body)
      expect(result["products"].size).to eq 1
    end

    it "with right data structure" do
      product

      get "/api/v1/products"

      result = JSON.parse(response.body)["products"].first
      expect(result["title"]).to eq "iPhone"
      expect(result["description"]).to eq "新一代 iPhone"
      expect(result["quantity"]).to eq product.quantity
      expect(result["price"]).to eq product.price
      expect(result["is_hidden"]).to be_falsey
      expect(result["category_name"]).to eq product.category_name
    end
  end

  describe "GET /api/v1/products/:id" do
    it "with right data structure" do
      product
      create_list(:comment, 3, product: product)
      comment = create(:comment, product: product, user: user)
      create(:comment)

      get "/api/v1/products/#{product.id}"

      result = JSON.parse(response.body)
      expect(result["title"]).to eq product.title
      expect(result["description"]).to eq product.description
      expect(result["quantity"]).to eq product.quantity
      expect(result["price"]).to eq product.price
      expect(result["is_hidden"]).to be_falsey
      expect(result["category_name"]).to eq product.category_name
      expect(result["comments"].size).to eq 4
      expect(result["comments"].first["body"]).to eq comment.body
      expect(result["comments"].first["user"]["email"]).to eq user.email
    end
  end

  describe "GET /api/v1/products/search" do
    it "without q params" do
      get "/api/v1/products/search"

      result = JSON.parse(response.body)
      expect(result["message"]).to eq "缺少必要的参数"
    end

    it "with matched result" do
      create_list(:public_product, 2)
      mac_products = create_list(:mac_product, 2)
      get "/api/v1/products/search", params: { q: "Ma" }

      result = JSON.parse(response.body)["products"]
      expect(result.size).to eq mac_products.size
      expect(result.first["title"]).to eq "Mac"
    end

    it "without matched result" do
      create_list(:public_product, 2)
      get "/api/v1/products/search", params: { q: "non_exists_product_title" }

      result = JSON.parse(response.body)
      expect(result["message"]).to eq "记录不存在"
    end

    it "paged" do
      create_list(:public_product, 3)
      second_page_products_size = 1

      get "/api/v1/products/search", params: { q: "phone", page: 2, per_page: 2 }

      result = JSON.parse(response.body)["products"]
      expect(result.size).to eq second_page_products_size
    end
  end
end