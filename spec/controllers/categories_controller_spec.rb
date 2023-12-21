require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:categories) { FactoryBot.create_list(:category, 3, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'loads all of the user categories into @categories' do
      get :index
      expect(assigns(:categories)).to match_array(categories)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        expect {
          post :create, params: { category: FactoryBot.attributes_for(:category) }
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the categories index' do
        post :create, params: { category: FactoryBot.attributes_for(:category) }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid attributes' do
    
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: categories.first.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the category' do
        put :update, params: { id: categories.first.id, category: { name: 'Updated' } }
        categories.first.reload
        expect(categories.first.name).to eq('Updated')
      end

      it 'redirects to the categories index' do
        put :update, params: { id: categories.first.id, category: { name: 'Updated' } }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid attributes' do
     
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the category' do
      expect {
        delete :destroy, params: { id: categories.first.id }
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to categories#index' do
      delete :destroy, params: { id: categories.first.id }
      expect(response).to redirect_to(categories_path)
    end
  end
end
