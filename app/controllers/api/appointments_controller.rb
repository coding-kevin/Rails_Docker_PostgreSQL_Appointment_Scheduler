class Api::AppointmentsController < ApplicationController
  # GET /api/appointments
  # GET /api/appointments.json
  def index  
      if params.has_key?(:length) && params.has_key?(:page) && params.has_key?(:past)
        if params[:past] == "1"
          appointments = Appointment.all.limit(params[:length]).where("start_time < ?", DateTime.now).offset(params[:page].to_i * params[:length].to_i)
        elsif params[:past] == "0"
          appointments = Appointment.all.limit(params[:length]).("start_time > ?", DateTime.now).offset(params[:page].to_i * params[:length].to_i)
        end
      elsif params.has_key?(:length) && params.has_key?(:page)
        appointments = Appointment.all.limit(params[:length]).offset(params[:page].to_i * params[:length].to_i)
      elsif params[:past] == "1"
        appointments = Appointment.where("start_time < ?", DateTime.now)
      elsif params[:past] == "0"
        appointments = Appointment.where("start_time > ?", DateTime.now)
      else
        appointments = Appointment.all
      end  

    render json: appointments.to_json(only: [:id, :created_at, :start_time, :duration_in_minutes], include: [patient: {only: [:name]}, doctor: {only: [:name, :id]}])
    
  end

  def show
    render html: params[:id]
  end


  def create
   
    appointment = Appointment.new(appointment_params)

    # respond_to do |format|
    #   if @appointment.save
    #     p "created"
    #     # render json: appointment.to_json
    #   else
    #     p "error"
    #     # render json: @appointment.errors, status: :unprocessable_entity 

    #   end
    # end
    
    p "created a new appointment: #{appointment.to_json}"
  end


private
    # Use callbacks to share common setup or constraints between actions.

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:doctor_id, :patient_id, :start_time, :duration_in_minutes)
    end
end