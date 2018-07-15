Spree::Product.class_eval do
  def self.import(file)
    unless file.nil?
      CSV.foreach(file.path, headers: true, col_sep: ';') do |row|
        hash = row.to_hash
        product = Spree::Product.find_by_name(hash['name'])
        unless product.nil?
          product_params = {
            "name": hash['name'],
            "description": hash['description'],
            "price": string_to_decimal(hash['price']),
            "shipping_category": Spree::ShippingCategory.where("name": 'Default').first,
            "slug": hash['slag']
          }
          Spree::Product.create!(product_params)
        end
      end
    end
  end

  def self.string_to_decimal(string)
    price_csv_comma = string.gsub(/[.,]/, '.' => '', ',' => '.')
    BigDecimal(price_csv_comma)
  end
end
