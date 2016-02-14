class NotamsController < ApplicationController

  def new
    @notam_data = NotamData.new
  end

  def create
    @notam_data = NotamData.new(data_received)
    if @notam_data.submit
      render :new
    else
      redirect_to notams_path
    end
  end

  def index
  end

  private

  def data_received
    params.require(:notam).permit(:data)
  end
end
