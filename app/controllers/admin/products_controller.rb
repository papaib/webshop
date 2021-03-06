class Admin::ProductsController < AdminController
	
	before_filter :find_root_categories, :only => [:index, :new, :edit, :update, :create]
	before_filter :find_all_tags, :except => [:index,:destroy]
 
	# GET /admin/products
  # GET /admin/products.xml
  def index
		if params[:category]
			@category = Category.find(params[:category])
			@products = @category.products
		else
			@category = nil
			@products = Product.find(:all)
		end
		
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /admin/products/new
  # GET /admin/products/new.xml
  def new
    @product = Product.new()
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /admin/products/1/edit
  def edit
    @product = Product.find(params[:id])
		ids = @product.attrs.collect(&:category_attribute_id)
		@new_attrs = (@product.category.attrs + @product.category.ancestors_category_attributes).delete_if do |category_attribute|
				ids.include?(category_attribute.id)
		end
  end

  # POST /admin/products
  # POST /admin/products.xml
  def create
    @product = Product.new(params[:product])
			
    respond_to do |format|
      if @product.save
        flash[:notice] = I18n.t 'products.created'
        format.html { redirect_to admin_products_path }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html do
					@tags += @product.tags # add newly builded tags to checkbox
					render :action => "new"
				end
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/products/1
  # PUT /admin/products/1.xml
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = I18n.t 'products.updated'
        format.html { redirect_to edit_admin_product_path(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
		flash[:notice] = I18n.t 'products.destroyed'
    respond_to do |format|
      format.html { redirect_to(admin_products_path) }
      format.xml  { head :ok }
    end
  end

	private
	def find_root_categories
		@root_categories = Category.roots()
	end
	
	def find_all_tags
		@tags = Tag.all()
	end
end
