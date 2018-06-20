class CustomersController < ApplicationController
  before_action :user_required
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
    @customer = Customer.new
  end

  def show
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to customers_path, notice: t('.successfully_created')
    else
      @customers = Customer.all
      render :index
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: t('.successfully_updated')
    else
      render :show
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: t('.successfully_destroyed')
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :active)
  end
end
