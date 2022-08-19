RSpec.describe 'Rails.application' do
    describe 'seeds.rb' do
        subject { Rails.application.load_seed}

        it do
            expect { subject }.to change(Appointment, :count).by(1000)
            .and change(Doctor, :count).by(10)
            .and change(Patient, :count).by(100)
        end
    end
end
