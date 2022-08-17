class Api::AppointmentsController < ApplicationController
  # before_action :set_appointment, only: [:show, :edit, :update, :destroy]

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
    @appointment = Appointment.new
  end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:content, :user_id)
    end
end