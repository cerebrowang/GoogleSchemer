class ConnectionsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :js

  def create
    @scheme = Scheme.where(id: params[:connection][:scheme_id]).first

    current_user.do!(@scheme)
    respond_with @scheme
  end

  def update
    @scheme = Scheme.where(id: params[:connection][:scheme_id]).first

    current_user.do!(@scheme)
    respond_with @scheme
  end

  def destroy
    @scheme = Connection.where(id: params[:id]).first.scheme
    
    current_user.done!(@scheme)
    respond_with @scheme
  end
end