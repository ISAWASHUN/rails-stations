class Admin::SchedulesController < ApplicationController
  before_action :set_movie
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = @movie.schedules
  end

  def new
    @schedule = @movie.schedules.build
  end

  def show
    # 必要に応じて内容を追加
  end

  def create
    @schedule = @movie.schedules.build(schedule_params)
    if @schedule.save
      redirect_to admin_movie_schedule_path(@movie, @schedule), notice: "スケジュールを登録しました。"
    else
      render :new
    end
  end

  def edit
    # set_schedule によって @schedule が設定されます
  end

  def update
    # set_schedule によって @schedule が設定されます
    if @schedule.update(schedule_params)
      redirect_to admin_movie_schedule_path(@movie, @schedule), notice: 'Schedule was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    # set_schedule によって @schedule が設定されます
    @schedule.destroy
    redirect_to admin_movie_schedules_path(@movie), notice: "スケジュールを削除しました"
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_schedule
    @schedule = @movie.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:movie_id, :start_time, :end_time)
  end
end
