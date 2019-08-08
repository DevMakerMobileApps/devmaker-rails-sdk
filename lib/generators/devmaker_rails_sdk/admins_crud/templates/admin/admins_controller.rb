class Admin::AdminsController < AdminController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]


  def index
    @admins = Admin.order(id: :desc).search_for(params[:q]).page(current_page)
  end

  def new
    @admin = Admin.new
    @admin.build_user
  end

  def create
    @admin = Admin.new(form_params)

    if @admin.save
      redirect_to admin_admins_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    params = form_params.to_h
    params[:user_attributes] = params[:user_attributes].except!(:password, :password_confirmation) if params[:user_attributes][:password].blank?

    if @admin.update(params)
      redirect_to admin_admins_path
    else
      render :edit
    end
  end

  def destroy
    @admin.destroy
    flash[:success] = "Admin removido."
    redirect_to admin_admins_path
  end

  private

  def form_params
    params.require(:admin).permit([
                                       :name,
                                       user_attributes: [
                                           :id,
                                           :email,
                                           :password,
                                           :password_confirmation,
                                       ],
                                   ])
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
