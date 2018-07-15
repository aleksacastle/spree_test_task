# TBD: transfer to background job
# fix validation slug error
Spree::Product.class_eval do
  def self.import(file)
    unless file.nil?
      options = {:value_converters => { :price => DecimalConverter }, :col_sep=>";", chunk_size: 1000}
      data = SmarterCSV.process(file.path, options)
      data.each do |row|
        product = Spree::Product.find_by_name(row[:name])
        unless product.nil?
          product_params = {
            "name": row[:name],
            "description": row[:description],
            "price": row[:price],
            "shipping_category": Spree::ShippingCategory.where("name": 'Default').first,
            "slug": row[:slug]
          }
          Spree::Product.create!(product_params)
        end
      end
    end
  end

  class DecimalConverter
    def self.convert(string)
      price_csv_comma = string.gsub(/[.,]/, '.' => '', ',' => '.')
      BigDecimal(price_csv_comma)
    end
  end
end
