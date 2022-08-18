require 'faker'

stopwatch_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#TODO: Remove this and make new rake file
Appointment.destroy_all
Patient.destroy_all
Doctor.destroy_all

10.times do
    doctor = Doctor.create(
        name: Faker::Name.name
    )
    for patient_key in 0..9
        patient = Patient.create(
            doctor_id: doctor.id,
            name: Faker::Name.name
        )
        # Only needs to be generated once per patient / avoids patient conflicts
        appointment_hour = (patient_key + 8).to_s
        5.times do
            appointment_date = Faker::Date.unique.backward(days: 365).strftime("%Y%m%d")
            past_appointment = Appointment.create(
                patient_id: patient.id,
                doctor_id: patient.doctor_id,
                duration_in_minutes: 50,
                start_time: "#{appointment_date}T#{appointment_hour}}"
            )   
        end
        5.times do
            appointment_date = Faker::Date.unique.forward(days: 365).strftime("%Y%m%d")
            future_appointment = Appointment.create(
                patient_id: patient.id,
                doctor_id: patient.doctor_id,
                duration_in_minutes: 50,
                start_time: "#{appointment_date}T#{appointment_hour}}"
            )
        end
        # Reset unique date values for next patient
        Faker::UniqueGenerator.clear
    end
end

stopwatch_end = Process.clock_gettime(Process::CLOCK_MONOTONIC)

elapsed_time = stopwatch_end - stopwatch_start


p "Seed successful: Created #{Doctor.count} doctors, #{Patient.count} patients, and #{Appointment.count} appointments. Elapsed time: #{elapsed_time.round()} seconds."
