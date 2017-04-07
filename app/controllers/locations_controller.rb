class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = current_user.locations

    respond_to do |format|
      format.js
    end
  end

  # GET /locations/1/edit
  def edit
    @location = current_user.locations.where(id: params[:id]).first
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = current_user.locations.build(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_url, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
        format.js
      else
        format.html { redirect_to locations_url, notice: 'Location was not successfully created.' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = current_user.locations.where(id: params[:id]).first

    respond_to do |format|
      if @location.update_attributes(location_params)
        format.html { redirect_to locations_url, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { redirect_to locations_url, notice: 'Location was not successfully updated.' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = current_user.locations.where(id: params[:id]).first
    @location.destroy

    respond_to do |format|
      # format.html { redirect_to locations_url }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def location_params
      params.require(:location).permit(:scheme_id, :name, :address, :latitude, :longitude)
    end  
end
