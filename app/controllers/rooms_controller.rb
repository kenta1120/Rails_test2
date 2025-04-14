class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def search
    @rooms = Room.all

    if params[:search].present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    render "index"
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(params.require(:room).permit(:name, :description, :price, :address, :image))
    if @room.save
      flash[:notice] = "施設が作成されました。"
      redirect_to @room
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:image, :name, :description, :price, :address))
      flash[:notice] = "施設情報が更新されました。"
      redirect_to @room
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設が削除されました。"
    redirect_to rooms_path
  end
end
