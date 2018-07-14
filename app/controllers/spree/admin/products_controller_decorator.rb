Spree::Admin::ProductsController.class_eval do
  def import
    Spree::Product.import(params[:file])
    redirect_to '/admin/products', notice: 'File was imported sucessfully'
  end
end
