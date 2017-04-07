
class TheAppController < ApplicationController
  layout "application"

  def welcome
    render(:layout => "layouts/welcome")
  end

  def home
    if user_signed_in?
      @scheme  = current_user.schemes.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      random_num = rand(User.count)
      @accomplices = User.limit(5).offset(random_num)
    end
  end

  def find
    @schemes = []

    if params[:search].present? and !params[:where].present?
      @schemes = Scheme.where("content like ?", "%#{params[:search]}%")
    end

    if !params[:search].present? and params[:where].present?
      @schemes = Scheme.all
    end

    if !params[:search].present? and !params[:where].present? and params[:c].present?
      @categorie = params[:c].strip! || params[:c] if params[:c]..present?
      @schemes = Scheme.tagged_with(@categorie)
    end

    if !params[:search].present? and !params[:where].present? and !params[:c].present?
      @schemes = Scheme.all
    end
  end

  def profile
  end

  def accomplices
  end

  def search
    if params[:search]
      @schemes = Scheme.where("content like ?", "%#{params[:search]}%")
      @tags = Tag.where("tags.name like ?", "%#{params[:search]}%")
      @users = User.where("name like ?", "%#{params[:search]}%")

      hash = @schemes.as_json( root: false, :only => [:id, :item_string, :class_name] )
      hash = hash + @tags.as_json( root: false, :only => [:id, :item_string, :class_name] )
      hash = hash + @users.as_json( root: false, :only => [:id, :item_string, :class_name] )

      render :json => hash
    elsif params[:where]
      @locations = Location.where("address like ?", "%#{params[:where]}%")
      render :json => @locations.to_json( root: false, :only => [:id, :item_string, :class_name] )
    else
      render :nothing => true, :status => 400
    end
  end

  def about
  end

  def jobs
  end

  def help
  end

  def policies
  end

  def sitemap
  end
end