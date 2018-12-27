require "rails_helper"

RSpec.describe Api::V1::ProductsController, type: :controller do

  let(:product) {create(:product)}

  it "GET #index" do
    get :index, params: { format: :json }

    expect(response).to have_http_status(200)
  end

  it "GET #show" do
    get :show, params: { id: product.id, format: :json }

    expect(response).to have_http_status(200)
  end
end
