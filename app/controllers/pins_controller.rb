class PinsController < ApplicationController
  before_action :check_login, only: [:edit, :update, :destory, :new, :create]
  def index
    @pins = Pin.all.order("created_at DESC")
  end
    
  def new
    @pin = Pin.new    
  end

  def show
    @pin = Pin.find(params[:id])
  end
  
  def edit
    @pin = Pin.find(params[:id]) 
  end
  
  def create
    @pin = current_user.pins.create(pins_params)
    if @pin.save  
      redirect_to root_path, notice: "The post is created successfull"
    else
      redirect_to new_pin_path 
    end     
  end

  def update
    @pin = Pin.find(params[:id])
    if @pin.update(pins_params)
      redirect_to pin_path(@pin), notice: "Update successfully" 
    else
      redirect_to edit_pin_path
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy
    redirect_to root_path, notice: "You have to login"
  end
  
  
  
  private 

  def pins_params
    params.require(:pin).permit(:title, :description, :image)
  end
  
  def check_login
    unless logged_in?
      redirect_to login_path
    end
  end
  
end
