require 'faker'

Appointment.destroy_all
Patient.destroy_all
Doctor.destroy_all

10.times do
doctor = Doctor.create(
    name: Faker::Name.unique.name
)
    10.times do
        patient = Patient.create(
            doctor_id: doctor.id,
            name: Faker::Name.unique.name
        )
        5.times do
            # start_time_raw = Faker::Time.unique.forward(days: 1826)
            # start_time_iso = 
            past_appointments = Appointment.create(
                patient_id: patient.id,
                doctor_id: patient.doctor_id,
                duration_in_minutes: 50,
                start_time: Faker::Time.unique.backward(days: 1826)
            )
        end

        5.times do 
            future_appointments = Appointment.create(
                patient_id: patient.id,
                doctor_id: patient.doctor_id,
                duration_in_minutes: 50,
                start_time: Faker::Time.unique.forward(days: 1826)
            )
        end
    end
end

# p "Created #{doctor.count} doctors, #{patient.count} patients, #{past_appointments.count} past appointments, #{future_appointments} future appointments."