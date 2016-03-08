class CategoriesController < ApplicationController
  def index
    authorize Category
    @categories = Category.all
    @categories = paginate(@categories).decorate
  end

  def edit
    @category = Category.find(params[:id])
    authorize @category
  end

  def update
    @category = Category.find(params[:id]).decorate
    authorize @category
    if @category.update_attributes(category_params)
      redirect_to categories_url, notice: 'Category has been updated'
    else
      render :update, flash: { error: 'Category could not be updated' }
    end
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params).decorate
    authorize @category
    if @category.save
      redirect_to categories_url, notice: 'Category has been created'
    else
      render :new, flash: { error: 'Category could not be created' }
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize @category
    if @category.destroy
      redirect_to categories_url, notice: 'Category has been deleted'
    else
      redirect_to categories_url, notice: 'Category could not be deleted'
    end
  end

  private

    def category_params
      params.require(:category).permit(:title, :refund_percentage)
    end

end
