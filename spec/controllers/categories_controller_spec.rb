require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'loads all of the user categories into @categories' do
      FactoryBot.create(:category, user:)
      get :index
      expect(assigns(:categories)).not_to be_empty
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
        expect do
          post :create, params: { category: FactoryBot.attributes_for(:category) }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the categories index' do
        post :create, params: { category: FactoryBot.attributes_for(:category) }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new category' do
        expect do
          post :create, params: { category: FactoryBot.attributes_for(:category, custom_name: nil) }
        end.to_not change(Category, :count)
      end

      it 're-renders the new method' do
        post :create, params: { category: FactoryBot.attributes_for(:category, custom_name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      category = FactoryBot.create(:category, user:)
      get :edit, params: { id: category.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let(:category) { FactoryBot.create(:category, user:) }

    context 'with valid attributes' do
      it 'updates the category' do
        put :update, params: { id: category.id, category: { name: 'Updated Category' } }
        category.reload
        expect(category.name).to eq('Updated Category')
      end

      it 'redirects to the categories index' do
        put :update, params: { id: category.id, category: { name: 'Updated Category' } }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the category' do
        put :update, params: { id: category.id, category: { name: nil } }
        category.reload
        expect(category.name).to_not be_nil
      end

      it 're-renders the edit method' do
        put :update, params: { id: category.id, category: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the category' do
      category = FactoryBot.create(:category, user:)
      expect do
        delete :destroy, params: { id: category.id }
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to categories#index' do
      category = FactoryBot.create(:category, user:)
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to(categories_path)
    end
  end
end
