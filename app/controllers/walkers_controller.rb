class WalkersController < ApplicationController
  def index
    @walkers =
      Walker
        .near(
          [latitude, longitude],
          params.fetch(:radius, Walker::MAX_RADIUS_IN_MILES)
        )
        .joins(:availabilities)
        .left_outer_joins(:walks)
        .where(
          "availabilities.start_at <= ? AND availabilities.end_at >= ?",
          start_at, end_at
        )
        .where(
          "walks.id IS NULL OR (walks.start_at NOT BETWEEN ? AND ? AND walks.end_at NOT BETWEEN ? AND ?)",
          start_at, end_at, start_at, end_at
        )
        .distinct
        .limit(page_size)
        .offset((page - 1) * page_size)

    render json: {
      walkers: @walkers
    }
  end

  private

  def start_at
    @start_at ||= params.require(:start_at).to_datetime
  end

  def end_at
    @end_at ||= if params[:end_at] && params[:duration].blank?
      params[:end_at].to_datetime
    elsif params[:duration] && params[:end_at].blank?
      start_at + params[:duration].to_i.minutes
    else
      raise ArgumentError.new("Either end_at or duration must be provided")
    end
  end

  def latitude
    # TODO: optionally accept a street address and geocode it
    @latitude ||= params.require(:latitude).to_f
  end

  def longitude
    @longitude ||= params.require(:longitude).to_f
  end
end
