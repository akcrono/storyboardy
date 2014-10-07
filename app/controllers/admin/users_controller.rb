module Admin
  class UsersController < BaseController
    def destroy
      user = User.find(params[:id])
      user.destroy
      flash[:notice] = "User has been deleted"
      redirect_to root_path
    end

    def update
      user = User.find(params[:id])

      if user.update(user_params)
        flash[:notice] = "User has been set as Admin"
        redirect_to root_path
      else
        flash[:notice] = "Invalid entry"
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit(:role)
    end
  end
end
