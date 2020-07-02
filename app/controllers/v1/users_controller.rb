class V1::UsersController < ApplicationController
    def current
        resp = {:current_integer => @current_user.current_integer}
        render json: { data: resp, errors: [] }, status: 200
        #render json: { 'current_integer': @current_user.current_integer }, status: 200
    end

    def next
        @current_user.current_integer += 1
        if @current_user.save
            resp = {:current_integer => @current_user.current_integer}
            render json: { data: resp, errors: [] }, status: 200
        else
            errors = ['Failed to increment the current integer']
            render json: { errors: errors }, status: 500
        end
    end

    def reset
        puts(params)

        errors = []

        if params[:current].to_s == ''
            errors << 'Current cannot be empty'
        else
            if !(params[:current].is_a? Integer)
                errors << 'Current must be an integer'
            else
                if params[:current] < 0
                    errors << 'Current cannot be negative'
                end
            end
        end

        if errors.length > 0
            render json: { errors: errors }, status: 400
            return
        end

        @current_user.current_integer = params[:current]
        if @current_user.save
            resp = {:current_integer => @current_user.current_integer}
            render json: { data: resp, errors: [] }, status: 200
            #render json: { 'current_integer': @current_user.current_integer }, status: 200
        else
            errors = ['Failed to reset the current integer']
            render json: { errors: errors }, status: 500
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

end