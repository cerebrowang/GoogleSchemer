class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :js

  def create
    @user = User.where(id: params[:relationship][:followed_id]).first

    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Relationship.where(id: params[:id]).first.followed

    current_user.unfollow!(@user)
    respond_with @user
  end
end