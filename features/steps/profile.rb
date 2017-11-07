class Spinach::Features::Profile < Spinach::FeatureSteps
  include Shared::Auth
  include Shared::Pages
  include Shared::Components

  step "I change my profile info" do
    within "#edit_user_#{@user.id}" do
      fill_in "user_name", with: "Mia Carter"
      fill_in "user_phone", with: "9990001234"

      click_on "Actualizar perfil"
    end
  end

  step 'I should see "Perfil actualizado" alert' do
    assert_alert("Perfil actualizado")
  end

  step "I unsuccessfully change my profile info" do
    within "#edit_user_#{@user.id}" do
      phone = "1" * 30
      fill_in "user_name", with: ""
      fill_in "user_phone", with: phone

      click_on "Actualizar perfil"
    end
  end

  step "I should see profile error messages" do
    assert_selector "span.error.block", text: "no puede estar en blanco"
    assert_selector "span.error.block", text: "es demasiado largo (24 caracteres máximo)"
  end

  step "I should see my new profile card" do
    profile_card("Mia Carter", @user.email, "9990001234")
  end

  step "I change my password" do
    within "#edit_user_#{@user.id}" do
      fill_in "user_current_password", with: "password"
      fill_in "user_password", with: "qwerty"
      fill_in "user_password_confirmation", with: "qwerty"

      click_on "Actualizar contraseña"
    end
  end

  step "I should see password change alert" do
    assert_alert("Contraseña actualizada")
  end

  step "I unsuccessfully change my password" do
    within "#edit_user_#{@user.id}" do
      fill_in "user_current_password", with: "pass"
      fill_in "user_password", with: "qwe"
      fill_in "user_password_confirmation", with: "qwerty"

      click_on "Actualizar contraseña"
    end
  end

  step "I should see a password error message" do
    assert_selector "span.error.block", text: "no es válido"
    assert_selector "span.error.block", text: "es demasiado corto (6 caracteres mínimo)"
    assert_selector "span.error.block", text: "no coincide"
  end

  step "I should see user menu with email" do
    user_menu("nav#default", @user.email, @user.email)
  end

  step "I change my email" do
    within "#edit_user_#{@user.id}" do
      fill_in "user_email", with: "foo@bar.com"

      click_on "Cambiar mi correo electrónico"
    end
  end

  step "I should see email change alert" do
    assert_alert("Recibirás un email con las instrucciones para confirmar tu correo")
  end

  step "I should see email pending reconfirmation" do
    assert_message("Esperando la confirmación del correo electrónico: #{@user.unconfirmed_email}", "info")
  end

  step "I unsuccessfully change my email" do
    within "#edit_user_#{@user.id}" do
      fill_in "user_email", with: ""

      click_on "Cambiar mi correo electrónico"
    end
  end

  step "I should see email error message" do
    within "#edit_user_#{@user.id}" do
      assert_selector "span.error.block", text: "no puede estar en blanco"
    end
  end

  step "I click on delete my account" do
    accept_confirm do
      click_on "Eliminar mi cuenta"
    end
  end
end
