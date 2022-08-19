class Api::DoctorsController < ApplicationController
    def index
      available_doctors = Doctor.includes(:appointments).references(:appointments).where('appointments.id IS NULL')
      render json: available_doctors.to_json
    end

    def create
    end
  end