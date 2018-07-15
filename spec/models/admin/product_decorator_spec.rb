require 'rails_helper'

describe Spree::Product, type: :model do
  context 'import csv method' do
    it 'creates new product' do
      file = Rack::Test::UploadedFile.new(Rails.root.join("spec/support/test.csv"))
      Spree::Product.import(file)
      expect(Spree::Product.all.last.name).to eq "Spree Bag"
    end
  end
end
