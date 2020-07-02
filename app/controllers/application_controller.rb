class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user

    private

    def authenticate_request
        errors = ['Not Authorized']
        @current_user = AuthorizeApiRequest.call(request.headers).result
        render json: { errors: errors }, status: 401 unless @current_user
    end
end
