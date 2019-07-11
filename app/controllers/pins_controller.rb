class PinsController < ApplicationController
  before_action :check_login, only: [:edit, :update, :destory, :new, :create, :dislike, :like]
  before_action :set_pins, only: [:update, :destroy, :show]

  def index
    @pins = Pin.all
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
      redirect_to pin_path(@pin), notice: "The post is created successfull"
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
    redirect_to root_path, notice: "Delete successfully"
  end

  def like
    @pin = Pin.find(params[:id])
    @pin.upvote_by current_user
    redirect_to :back
  end

  def dislike
    @pin = Pin.find(params[:id])
    @pin.downvote_by current_user
    redirect_to :back
  end
  
  private 

  def set_pins
    @pin = Pin.find(params[:id])
  end
  
  def pins_params
    params.require(:pin).permit(:title, :description, :image)
  end
  
  def check_login
    unless logged_in?
      redirect_to login_path
    end
  end
  
end
