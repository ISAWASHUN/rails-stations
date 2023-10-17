class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :reservation, :new_reservation, :create_reservation]

  def index
    @movies = Movie.all
  end

  def show
    @dates = (Date.today..Date.today + 6.days).to_a
    @schedules = @movie.schedules
  end

  def reservation
    @date = params[:date]
    @schedule_id = params[:schedule_id]

    unless @date && @schedule_id
      redirect_to movie_path(@movie), alert: '日付またはスケジュールIDが指定されていません。'
      return
    end

    @sheets = Sheet.all
  end

  def new_reservation
    @date = params[:date]
    @sheet_id = params[:sheet_id]
    @schedule_id = params[:schedule_id]

    unless @date && @sheet_id && @schedule_id
      redirect_to movie_path(@movie), alert: '日付、座席ID、またはスケジュールIDが指定されていません。'
      return
    end
  end

  def create_reservation
    reservation = Reservation.new(
      date: params[:date],
      schedule_id: params[:schedule_id],
      sheet_id: params[:sheet_id],
      email: params[:email],
      name: params[:name]
    )

    if reservation.save
      redirect_to movie_path(@movie), notice: '予約が完了しました'
    else
      redirect_to reservation_movie_path(@movie, schedule_id: params[:schedule_id], date: params[:date]), alert: 'その座席はすでに予約済みです'
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id] || params[:movie_id])
  end
end
