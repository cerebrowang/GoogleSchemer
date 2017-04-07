class SchemesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  def index
    @schemes = current_user.schemes
  end

  def new
    @scheme = Scheme.new
  end

  def show
    @scheme = Scheme.where(id: params[:id]).first
    @comment = Comment.new(:user_id => current_user.id)

    @todo_schemers = @scheme.schemers.where("is_done = ?", false)
    @done_schemers = @scheme.schemers.where("is_done = ?", true)
  end

  def create
    @scheme = current_user.schemes.build(scheme_params)
    @scheme.image = "scheme/"+["normal", "default.png"].compact.join('_')
    @scheme.image = ""

    if @scheme.save
      if params[:comments][:content].present?
        @comment = @scheme.comments.create(:user_id => current_user.id, :content => params[:comments][:content])
      end      
      current_user.do!(@scheme)
      redirect_to root_path
    else
      #@feed_items = []
      #render 'the_app/home'
      redirect_to root_path
    end
  end

  def update
    @scheme = Scheme.where(id: params[:id]).first

    if @scheme.update_attributes(scheme_params)
      #flash[:notice] = "Successfully updated this scheme."
      redirect_to :action => :show, :id => @scheme.id
    else
      render 'the_app/home'
    end
  end

  def create_where
    @scheme = Scheme.where(id: params[:id]).first
    @location = Location.where(id: params[:where_id]).first

    @location.update_attributes(:scheme_id => @scheme.id)
    if @location.save
      render 'update_where.js.erb', :locals => { :scheme => @scheme }
    else
      render :nothing => true, :status => 500
    end
  end

  def update_where
    @scheme = Scheme.where(id: params[:id]).first

    respond_to do |format|
      if @scheme.update_attributes(scheme_params)
        format.js { render :nothing => true, :status => 204 }
      else
        format.js
      end
    end
  end

  def destroy_where
    @scheme = Scheme.where(id: params[:id]).first
    @location = Location.where(id: params[:location_id]).first

    @location.update_attributes(:scheme_id => nil)
    if @location.save
      render 'update_where.js.erb', :locals => { :scheme => @scheme }
    else
      render :nothing => true, :status => 500
    end
  end

  def destroy
    @scheme.destroy
    redirect_to root_path
  end


  def mark_todo
    @scheme = Scheme.where(id: params[:id]).first
    current_user.do!(@scheme)
  end

  def mark_done
    @scheme = Scheme.where(id: params[:id]).first
    current_user.done!(@scheme)
  end
  
  def index_tags
    if params[:search]
      @tags = Tag.where("tags.name like ?", "%#{params[:search]}%")
      render :json => @tags.as_json( root: false, :only => [:id, :item_string, :class_name] )
    else
      render :nothing => true, :status => 400
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.s
    def scheme_params
      params.require(:scheme).permit(:user_id, :content, :tag_list, :where_type,
                                   :image, :image_cache, :remove_image, :remote_image_url)
    end

    def correct_user
      @scheme = current_user.schemes.where(id: params[:id]).first

      redirect_to root_path if @scheme.nil?
    end
end