require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /index" do
    it "fetches books list" do 
      book = Book.create(name: "AAA")

      get "/books.json"

      data = JSON.parse(response.body)
      expect(data.count).to eq(1)
      expect(data[0]["name"]).to eq("AAA")
    end
  end
end
