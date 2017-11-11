class GraphqlController < ApplicationController
  protect_from_forgery except: [:execute]
  before_action :authenticate_with_token!, only: [:execute]

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }
    result = SkywrathSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  def sign_in
    email, password = params[:email], params[:password]

    unless email || password
      render json: { error: "Missing params" }, status: :bad_request
      return
    end

    user = User.find_by(email: email)

    if user && user.valid_password?(password)
      render json: { access_token: user.access_token }, status: :ok
    else
      render json: { error: "Email or password invalid" }, status: :bad_request
    end
  end

  def sign_out
    access_token = params[:access_token]

    unless access_token
      render json: { error: "Bad request" }, status: :bad_request
      return
    end

    user = User.find_by(access_token: access_token)

    if user && user.is_valid_access_token?(access_token)
      render json: { message: "Have a nice day!" }, status: :accepted
    else
      render json: { error: "Bad request" }, status: :bad_request
    end
  end

private

  def authenticate_with_token!
    return true if user_signed_in?

    access_token = request.headers["X-Access-Token"]

    unless access_token
      head :bad_request
      return
    end

    user = User.find_by(access_token: access_token)

    if user && user.is_valid_access_token?(access_token)
      bypass_sign_in(user)
    else
      head :unauthorized
    end
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
