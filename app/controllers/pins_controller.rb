class PinsController < ApplicationController
  before_action :check_login, only: [:edit, :update, :destory, :new, :create, :dislike, :like]
  before_action :set_pins, only: [:update, :destroy, :show, :like, :dislike]

  def index
    @pins = Pin.all
  end
    
  def new
    @pin = Pin.new    
  end

  def show
  end
  
  def edit
    @pin = Pin.find(params[:id]) 
  end

  def upload_image
    client_id = '6f670eda56814da'
    client = Imgur::Client.new(client_id)
    image_path = pins_params[:image]
    image = Imgur::LocalImage.new(image_path, title: 'Awesome photo')
    @uploaded = client.upload(image)
    return @uploaded
  end
  
  
  def create
    uploaded = upload_image
    data = pins_params
    data[:image] =  uploaded.link
    @pin = current_user.pins.create(data)
    if @pin.save  
      redirect_to pin_path(@pin), notice: "The post is created successfull"
    else
      redirect_to new_pin_path 
    end     
  end

  def update
    uploaded = upload_image
    data = pins_params
    data[:image] =  uploaded.link
    if @pin.update(data)
      redirect_to pin_path(@pin), notice: "Update successfully" 
    else
      redirect_to edit_pin_path
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path, notice: "Delete successfully"
  end

  def like
    @pin.upvote_by current_user
    redirect_to :back
  end

  def dislike
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
      redirect_to login_path,notice: "You have to login"
    end
  end
  
end
