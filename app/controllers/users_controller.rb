class UsersController < ApplicationController
  before_filter :authenticate_user!, 
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
  	authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.where(id: params[:id]).first
    @schemes = @user.schemes.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create    
    @user = User.new(user_params)

    #binding.pry
    # returns Geocoder::Result object
    result = request.location

    @user.locations.create(name: "Home", address: result.address);
    @user.locations.create(name: "Work", address: "");
    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Huing!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
      if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.where(id: params[:id]).first.destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @user = User.where(id: params[:id]).first

    if params[:search]
      @users = @user.followed_users.where("name like ?", "%#{params[:search]}%")
    else
      @users = @user.followed_users
    end
    @count = @user.followed_users.count
  end

  def followers
    @user = User.where(id: params[:id]).first
    if params[:search]
      @users = @user.followers.where("name like ?", "%#{params[:search]}%")
    else
      @users = @user.followers
    end
    @count = @user.followers.count
  end

  def activity
      @user = User.where(id: params[:id]).first
    
    if user_signed_in?
      @schemes  = current_user.schemes
    end
  end
  
  def want
    @user = User.where(id: params[:id]).first
    @schemes = Scheme.joins(:reverse_connections).where("schemer_id = ? AND is_done = ?", @user.id, false)
  end
  
  def done
    @user = User.where(id: params[:id]).first
    @schemes = Scheme.joins(:reverse_connections).where("schemer_id = ? AND is_done = ?", @user.id, true)
  end

  def authored
     @user = User.where(id: params[:id]).first
     @schemes = Scheme.where("user_id = ?", @user.id)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.s
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :remember_me, :confirmed_at,
                                   :image, :image_cache, :remove_image, :remote_image_url)
    end

    def correct_user
      @user = User.where(id: params[:id]).first
      redirect_to(root_path) unless current_user == @user
    end

    def admin_user
      redirect_to(root_path) unless current_user.has_role? :admin
    end
end