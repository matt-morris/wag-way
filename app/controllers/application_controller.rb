class ApplicationController < ActionController::API
  rescue_from StandardError, with: :five_hundred
  rescue_from ArgumentError, with: :bad_request
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def bad_request(error)
    render json: { errors: [error.message] }, status: :bad_request
  end

  def not_found(error)
    render json: { errors: [error.message] }, status: :not_found
  end

  def five_hundred(error)
    render json: { errors: [
      Rails.env.development? ? error.message : "Internal Server Error"
    ] }, status: :internal_server_error
  end

  def page
    @_page_number ||= params.fetch(:page, 1).to_i.clamp(1, Float::INFINITY)
  end

  def page_size
    @_page_size ||= params.fetch(:page_size, 10).to_i.clamp(1, 100)
  end
end
