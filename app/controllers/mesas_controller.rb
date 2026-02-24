class MesasController < ApplicationController
  def index
    year  = params[:year]&.to_i  || Date.today.year
    month = params[:month]&.to_i || Date.today.month
    @date = Date.new(year, month, 1)

    result = GoogleCalendarService.events_for_month(@date)
    @error = result.nil?

    @events_by_date = {}
    (result || []).each do |event|
      day = event.start.date_time&.to_date || event.start.date
      (@events_by_date[day] ||= []) << event
    end
  end

  def new
  end

  def create
    result = GoogleCalendarService.create_event(
      title:       params[:title],
      date:        params[:date],
      start_time:  params[:start_time],
      end_time:    params[:end_time],
      description: params[:description],
      mesas:       params[:mesas]
    )

    if result
      redirect_to mesas_path, notice: "Evento creado correctamente."
    else
      flash.now[:alert] = "No se pudo crear el evento en Google Calendar."
      render :new, status: :unprocessable_entity
    end
  end
end
