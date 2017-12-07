class Spinach::Features::Alerts < Spinach::FeatureSteps
  include Shared::Auth
  include Shared::Pages

  Given "I have one alert" do
    @user.alerts.create!
  end

  Given "I have 30 alerts" do
    create_list(:alert, 30, author: @user)
  end

  Then "I should see one alert" do
    assert_selector ".alert", count: 1
  end

  Given "I have no alerts" do
    @user.alerts.destroy_all
  end

  Then "I should not see alerts paginator" do
    assert_no_selector '#alerts-paginator'
  end

  Then "I should see alerts paginator" do
    assert_selector "#alerts-paginator"
  end

  Then "I should see 20 alerts" do
    assert_selector ".alert", count: 20
  end

  Then "I should not see alerts" do
    assert_selector ".alert", count: 0
  end

  Then "I should see blank slate" do
    assert_text "No hay alertas"
  end
end
