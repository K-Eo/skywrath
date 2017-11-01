require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }
  subject { response }

  describe '#GET index' do
    before do
      sign_in(user) unless user.nil?
      get :index
    end

    context 'when logged in' do
      it { is_expected.to redirect_to(dashboard_path) }
    end

    context 'when logged out' do
      let(:user) { nil }

      it { is_expected.to have_http_status(:ok) }
    end
  end
end
