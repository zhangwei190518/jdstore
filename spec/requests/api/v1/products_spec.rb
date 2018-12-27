require "rails_helper"

RSpec.describe "Products", type: :request do

  let(:product) {create(:product)}
  let(:category) {create(:category)}
  let(:user) {create(:user, email: "test@gmail.com")}

  describe "GET /api/v1/products" do
    context "right count" do
      before do
        create_list(:product, 3, category: category)
      end
      
      it "no params" do
        get "/api/v1/products", params: { format: :json }

        result = JSON.parse(response.body)
        expect(result["products"].size).to eq 3
      end

      it "with category_name params" do
        create(:product, user: user, category: create(:category, name: "Mac"))

        get "/api/v1/products", params: { category_name: "手机", format: :json }

        result = JSON.parse(response.body)
        expect(result["products"].size).to eq 3
      end
    end

    it "paged" do
      create_list(:product, 5)

      get "/api/v1/products", params: { page: 3, per_page: 2, format: :json }

      result = JSON.parse(response.body)
      expect(result["products"].size).to eq 1
    end

    it "with right data structure" do
      product

      get "/api/v1/products", params: { format: :json }

      result = JSON.parse(response.body)["products"].first
      expect(result["title"]).to eq "iPhone"
      expect(result["description"]).to eq "新一代 iPhone"
      expect(result["quantity"]).to eq 20
      expect(result["price"]).to eq 10499
      expect(result["is_hidden"]).to be_falsey
      expect(result["category_name"]).to eq "手机"
    end
  end

  describe "GET /api/v1/products/:id" do
    it "with right data structure" do
      product
      create_list(:comment, 3, product: product)
      create(:comment, product: product, user: user, body: "评论试试")
      create(:comment)

      get "/api/v1/products/#{product.id}", params: { format: :json }

      result = JSON.parse(response.body)
      expect(result["title"]).to eq "iPhone"
      expect(result["description"]).to eq "新一代 iPhone"
      expect(result["quantity"]).to eq 20
      expect(result["price"]).to eq 10499
      expect(result["is_hidden"]).to be_falsey
      expect(result["category_name"]).to eq "手机"
      expect(result["comments"].size).to eq 4
      expect(result["comments"].first["body"]).to eq "评论试试"
      expect(result["comments"].first["user"]["email"]).to eq "test@gmail.com"
    end
  end
end
