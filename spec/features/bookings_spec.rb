require 'rails_helper'

RSpec.feature "Bookings", type: :feature do

	before do
		user = User.create!(email: 'maria@esl.com.br', password: '123456', password_confirmation: '123456')
 		login_as(user, :scope => :user)
	end

 	it 'Visit Bookings page' do
 		visit(bookings_path)
 		expect(page).to have_current_path(bookings_path)
 	end

 	it 'Find' do
 		visit(new_booking_path)
 		expect(find('#titulo').find('h1')).to have_content('Reservar')
 	end

 	it 'Create a Booking' do
 		visit(new_booking_path)
 		fill_in('Data', with: '11-12-2021')
 		select('08:00', :from => 'Hora')
 		fill_in('Descrição', with: 'Reunião Create a Booking')
 		click_button('Salvar')
 		expect(page).to have_content('Reserva cadastrada com sucesso!')
 	end
end
