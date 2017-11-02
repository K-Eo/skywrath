module Support
  module AuthLinks
    def sign_in_link
      assert has_link?("Iniciar sesión", href: new_user_session_path)
    end

    def sign_up_link
      assert has_link?("Crear cuenta", href: new_user_registration_path)
    end

    def forgot_password_link
      assert has_link?("Recuperar contraseña", href: new_user_password_path)
    end

    def confirmation_link
      assert has_link?("Confirmar cuenta", href: new_user_confirmation_path)
    end

    def unlock_link
      assert has_link?("Desbloquear cuenta", href: new_user_unlock_path)
    end
  end
end
