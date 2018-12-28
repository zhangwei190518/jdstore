require "rails_helper"

RSpec.describe Api::V1::ProductsController, type: :controller do

  let(:product) { create(:public_product) }

  it "GET #index" do
    get :index

    expect(response).to have_http_status(200)
  end

  it "GET #show" do
    get :show, params: { id: product.id }

    expect(response).to have_http_status(200)
  end

  describe "GET #search" do
    it "with matched result" do
      product

      get :search, params: { q: "iPhone" }

      expect(response).to have_http_status(200)
    end

    it "without matched result" do
      get :search, params: { q: "non_exists_product_title" }

      expect(response).to have_http_status(404)
    end
  end
end
