require 'rails_helper'

RSpec.describe 'AcquisitionController', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/acquisition/1'
      expect(response).to have_http_status(302)
    end

    it 'returns an error response for a wrong path' do
      get '/acquisition'
      expect(response).to have_http_status(404)
    end

    it 'should redirects to the sign in page for an unauthenticated user' do
      get '/acquisition/2'
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
