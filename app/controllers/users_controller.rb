class UsersController < ApplicationController
    skip_before_action :authorized, only: [:login, :create]

    def login
        @user = User.find_by(username: params[:username].downcase)
        
        if @user && @user.authenticate(params[:password])
            token = JWT.encode({user_id: @user.id}, "secret")
            render json: {token: token}
            return
        end
        
        render json: {error: "Invalid username or password"}
        return
    end

    def create
        @userAlreadyExists = User.find_by(username: params[:username].downcase)

        if @userAlreadyExists
            render json: {error: "Username already exists"}
            return 
        end

        @user = User.new(user_params.merge(username: params[:username].downcase))

        if @user.save
            token = JWT.encode({user_id: @user.id}, "secret")
            render json: {token: token, user: @user.as_json(only: [:id, :username])}
        else
            render json: { errors:
                @user.errors.full_messages
            }
        end
    end

    private
        def user_params
            params.require(:user).permit(:username, :password)
        end
end
