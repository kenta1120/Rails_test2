class SearchesController < ApplicationController
  def index
    @rooms = Room.all

    if params[:search].present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    @count = @rooms.count
  end
end
