class Api::AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /api/appointments
  # GET /api/appointments.json
  def index
    # TODO: Requirement 2: api/appointments endpoint
    # TODO: Requirement 3: allow the api/appointments endpoint to return filtered
    appointments = Appointment.all  
    render json: appointments.to_json

    # head :ok
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