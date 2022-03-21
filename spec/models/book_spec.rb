require 'rails_helper'

RSpec.describe Book, type: :model do
  it "initializes book instance" do 
    expect(Book.new(name: "aaa").name).to eq("aaa")
  end
end
