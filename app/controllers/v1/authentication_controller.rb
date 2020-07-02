class V1::AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
        command = AuthenticateUser.call(params[:email], params[:password])

        if command.success?
            resp = {:auth_token => command.result}
            render json: { data: resp }, status: 200
        else
            render json: { errors: command.errors }, status: :unauthorized
        end
    end

    # POST /register
    def register
        #puts("MY PARAMS")
        #puts(params)

        errors = []

        if params[:email].to_s == ''
            #render json: { error: 'Email cannot be empty.' }, status: 400
            #return
            errors << 'Email cannot be empty'
        end

        if !(params[:email] =~ URI::MailTo::EMAIL_REGEXP)
            errors << 'Invalid email address'
        end

        if params[:password].to_s == ''
            errors << 'Password cannot be blank'
        end

        if errors.length > 0
            render json: { errors: errors }, status: 400
            return
        end

        @user = User.new(email: params[:email], password: params[:password])
        if @user.save
            command = AuthenticateUser.call(params[:email], params[:password])

            if command.success?
                resp = {:auth_token => command.result}
                render json: { data: resp }, status: 200
            else
                render json: { errors: command.errors }, status: :unauthorized
            end
        else
            #puts(@user.errors.full_messages)
            render json: { errors: @user.errors.full_messages }, status: 400
        end
    end

    #private

    #def user_params
    #    params.require(:user).permit(:email, :password)
    #end
end