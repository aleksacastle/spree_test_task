Spree::Admin::ProductsController.class_eval do
  require 'smarter_csv'
  def import
    Spree::Product.import(params[:file])
    unless params[:file].nil?
      redirect_to '/admin/products', notice: 'File was imported sucessfully'
    else
      redirect_to '/admin/products', notice: 'Please choose file'
    end
  end
end
