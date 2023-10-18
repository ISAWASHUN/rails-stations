class ReservationsController < ApplicationController

  def new
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])

    # dateとsheet_idの存在を確認
    unless params[:date] && params[:sheet_id]
      flash[:alert] = "日付と座席IDの両方が必要です。"
      redirect_to movies_path
      return
    end

    @sheet = Sheet.find(params[:sheet_id])

    # 予約済みの席を確認
    if Reservation.exists?(schedule_id: @schedule.id, sheet_id: @sheet.id)
      flash[:alert] = "この座席はすでに予約されています。"
      redirect_to reservation_movie_path(id: @movie.id, date: params[:date], schedule_id: @schedule.id)
      return
    end

    @reservation = Reservation.new

    # 予約済みの席のIDを取得
    @reserved_sheet_ids = Reservation.where(schedule_id: @schedule.id).pluck(:sheet_id)
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if Reservation.exists?(schedule_id: @reservation.schedule_id, sheet_id: @reservation.sheet_id)
      flash[:alert] = "この座席はすでに予約されています。"
      redirect_to reservation_movie_path(id: @reservation.schedule.movie_id, date: @reservation.date, schedule_id: @reservation.schedule_id) and return
    end

    if @reservation.save
      flash[:notice] = "予約が完了しました。"
      redirect_to reservation_movie_path(id: @reservation.schedule.movie_id, date: @reservation.date, schedule_id: @reservation.schedule_id)
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:schedule_id, :sheet_id, :date, :name, :email)
  end
end
