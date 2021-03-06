class Spinach::Features::User < Spinach::FeatureSteps
  include Shared::Auth
  include Shared::Components
  include Shared::Pages

  step "Sidebar profile item should be active" do
    assert_selector "#settings-sidebar .list-group-item.active", text: "Perfil"
  end

  step "Sidebar account item should be active" do
    assert_selector "#settings-sidebar .list-group-item.active", text: "Cuenta"
  end
end
