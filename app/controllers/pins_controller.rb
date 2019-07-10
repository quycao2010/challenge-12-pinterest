class PinsController < ApplicationController
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
    @pin = Pin.create(pins_params)
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
    redirect_to root_path
  end
  
  
  
  private 

  def pins_params
    params.require(:pin).permit(:title, :description)
  end
  
end
