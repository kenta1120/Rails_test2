class ReservationsController < ApplicationController
  before_action :set_room, only: [:index, :new, :create]

  def index
    @reservations = @room.reservations
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.build
  end

  def create
    @room = Room.find(params[:room_id])
    reservation_params = session.delete(:reservation_data) || params.require(:reservation).permit(:guests, :check_in, :check_out)
    @reservation = @room.reservations.build(params.require(:reservation).permit(:guests, :check_in, :check_out).merge(user: current_user))
    @reservation.user = current_user
    @reservation.total_price = calculate_price(@reservation)

    if @reservation.save
      flash[:notice] = "予約が完了しました。"
      redirect_to room_reservations_path(@room)
    else
      @room = Room.find(params[:room_id])
      render "new"
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to room_reservations_path(@reservation.room)
  end

  def my_reservations
    @reservations = current_user.reservations.includes(:room)
  end

  def confirm
    if request.post?
      session[:reservation_data] = params.require(:reservation).permit(:guests, :check_in, :check_out).to_h
    end

    unless session[:reservation_data]
      redirect_to new_room_reservation_path(params[:room_id])
      return
    end
    
    @room = Room.find(params[:room_id])
    reservation_params = ActionController::Parameters.new(session[:reservation_data]).permit(:guests, :check_in, :check_out)
    @reservation = @room.reservations.build(reservation_params.merge(user: current_user))

    if @reservation.valid?
      @stay_days = (@reservation.check_out.to_date - @reservation.check_in.to_date).to_i
      @reservation.total_price = calculate_price(@reservation)
      render :confirm
    else
      render :new
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def calculate_price(reservation)
    if reservation.check_in.nil? || reservation.check_out.nil?
      return 0
    end

    days = (reservation.check_out - reservation.check_in).to_i
    days * reservation.room.price * reservation.guests
  end
end
