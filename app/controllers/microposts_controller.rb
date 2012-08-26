class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_to root_url
  end
  
  
  private
    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url if @micropost.nil?
      # equivalent to:
      # @micropost = current_user.microposts.find(params[:id])
      #rescue
      # redirect_to root_url
      # for security purposes, it is good practice to run lookups through association
    end
end