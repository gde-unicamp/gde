require 'spec_helper'

describe 'login' do

  let(:email) { "alunotest@mailinator.com" }
  let(:password) { "password01" }
  let(:user) { User.create!(name: "Aluno1", email: email, password: password) }

  it 'should be sucessfull if the user enter the correct email and password' do
    user.wont_be_nil

    visit root_path
    fill_in 'Registro do Aluno ou E-mail', with: email
    fill_in 'Senha', with: password
    click_button 'Create User'

    current_path.must_equal root_path
    page.has_content? 'Pota Beranizo'

    User.delete_all
  end
end
