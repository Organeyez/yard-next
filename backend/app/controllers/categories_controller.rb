class CategoriesController < ApplicationController

  def index
    @categories = Category.order(:title)
    render :json => @categories
  end 

  def show
    @category = Category.find(params[:id])
    @resources = @category.resources
    render :json => @resources
  end

  def new
    @category = Category.new 
    render :json => @category
  end

  def create
    @category = Category.new(category_params) 
    if @category.save
      redirect_to root_path, notice: "Your category was successfully created."
    else
      @errors = @category.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
  end

  def update
  end

  private 
  def category_params
    params.require(:category).permit(:title)
  end

end
