require 'rails_helper'

RSpec.feature "Users", type: :feature do

 	it 'Visit User page' do
 		visit(new_user_registration_path)
 		expect(page).to have_current_path(new_user_registration_path)
 	end

 	it 'Create a User' do
 		visit(new_user_registration_path)
 		fill_in('Email', with:'mflores@eslsistemas.com.br')
 		fill_in('Password', with: '123456')
 		fill_in('Password Confirmation', with: '123456')
 		click_button('Sign up')
 		expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
 	end
end
