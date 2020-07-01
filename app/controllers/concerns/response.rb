module Response
  def json_response object, status=:ok
    if object.valid?
      render json: object, status: status
    else
      render json: { errors: object.errors.full_messages },
             status: :unprocessable_entity
    end
  end
end

