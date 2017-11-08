class Spinach::Features::Alerts < Spinach::FeatureSteps
  include Shared::Auth
  include Shared::Pages
  include Shared::Components

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

  step "I should not see alerts" do
    assert_selector ".alert", count: 0
  end

  step "I should see no alerts message" do
    assert_text "No hay alertas"
  end

  step "I should not see alerts paginator" do
    assert_paginator "#alerts_paginator", false
  end

  step "I should see alerts paginator" do
    assert_paginator "#alerts_paginator"
  end

  step "I have 30 alerts" do
    create_list(:alert, 30, author: @user)
  end

  step "I should see 24 alerts" do
    assert_selector ".alert", count: 24
  end

  step "I click on next page" do
    find("a[title='Siguiente']").click
  end

  step "I should see 6 alerts" do
    assert_selector ".alert", count: 6
  end
end
