# app/controllers/admin/reservations_controller.rb
class Admin::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.joins(:schedule).where("schedules.end_time > ?", Time.now)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.date = Date.today
    if @reservation.save
      redirect_to admin_reservations_path, notice: 'Reservation was successfully created.'
    else
      flash[:error] = @reservation.errors.full_messages.join(", ")
      render :new, status: 400 # ここを修正して、ステータスコード400を返すようにします
    end
  end


  def show
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservation_path(@reservation), notice: 'Reservation was successfully updated.'
    else
      flash[:error] = @reservation.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to admin_reservations_path, notice: 'Reservation was successfully destroyed.'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :name, :email)
  end
end
