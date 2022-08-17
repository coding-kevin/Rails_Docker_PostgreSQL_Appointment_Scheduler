class Api::DoctorsController < ApplicationController
    def index
      #Requirement 4: create a new endpoint api/doctors

      doctors = Doctor.all
      render json: doctors.to_json

      available_doctors = Doctor.includes(:appointments).references(:appointments).where('appointments.id IS NULL')
      # render json: doctorsWithoutAppointments.to_json
      # head :ok
    end

  

   

    def create

    end
  end