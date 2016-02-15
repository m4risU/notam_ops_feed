class NotamsController < ApplicationController

  before_action :set_filter

  def new
    @notam_form = NotamForm.new(@filter)
  end

  def create
    @notam_form = NotamForm.new(@filter)
    if @notam_form.validate(data_received) && @notam_form.save
      InterpreterService.process(@filter.filtered_data)
      redirect_to notams_path
    else
      render :new
    end
  end

  def index
    @notams = Notam.page(params[:page]).per(20)
  end

  private

  def set_filter
    @filter = FilterService.new
  end

  def data_received
    params.require(:notam).permit(:data)
  end
end
