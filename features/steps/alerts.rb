class Spinach::Features::Alerts < Spinach::FeatureSteps
  include Shared::Auth
  include Shared::Pages

  step "I have one alert" do
    @user.alerts.create!
  end

  step "I send one alert" do
    find("a[title='Nueva Alerta']").click
  end

  step "I should see one alert" do
    assert_selector ".alert", count: 1
  end

  step "I have no alerts" do
    @user.alerts.destroy_all
  end

  step "I should see no alerts" do
    assert_selector ".alert", count: 0
  end

  step "I should see no alerts message" do
    assert_text "No hay alertas"
  end
end
