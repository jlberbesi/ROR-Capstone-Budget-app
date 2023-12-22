require 'rails_helper'

RSpec.describe AcquisitionController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category, user:) }
  let(:acquisition) { FactoryBot.create(:acquisition, author: user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    context 'when category exists' do
      it 'renders the show template' do
        get :show, params: { id: category.id }
        expect(response).to render_template(:show)
      end

      it 'loads the correct category' do
        get :show, params: { id: category.id }
        expect(assigns(:category)).to eq(category)
      end
    end

    context 'when category does not exist' do
      it 'redirects to categories path with an alert' do
        get :show, params: { id: 'nonexistent' }
        expect(response).to redirect_to(categories_path)
        expect(flash[:alert]).to match(/Category not found./)
      end
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { category_id: category.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new acquisition' do
        expect do
          post :create, params: { category_id: category.id, acquisition: FactoryBot.attributes_for(:acquisition) }
        end.to change(Acquisition, :count).by(1)
      end

      it 'redirects to the show page with a notice' do
        post :create, params: { category_id: category.id, acquisition: FactoryBot.attributes_for(:acquisition) }
        expect(response).to redirect_to(acquisition_path(category.id))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new acquisition' do
        expect do
          post :create, params: { category_id: category.id, acquisition: FactoryBot.attributes_for(:acquisition, name: nil) }
        end.to_not change(Acquisition, :count)
      end

      it 're-renders the new template' do
        post :create, params: { category_id: category.id, acquisition: FactoryBot.attributes_for(:acquisition, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: acquisition.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the acquisition' do
        put :update, params: { id: acquisition.id, acquisition: { name: 'New Name', amount: 20 } }
        acquisition.reload
        expect(acquisition.name).to eq('New Name')
        expect(acquisition.amount).to eq(20)
      end

      it 'redirects to the categories path with a notice' do
        put :update, params: { id: acquisition.id, acquisition: { name: 'New Name', amount: 20 } }
        expect(response).to redirect_to(categories_path)
        expect(flash[:notice]).to match(/Transaction was successfully updated./)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the acquisition' do
        put :update, params: { id: acquisition.id, acquisition: { name: nil } }
        acquisition.reload
        expect(acquisition.name).not_to be_nil
      end

      it 're-renders the edit template' do
        put :update, params: { id: acquisition.id, acquisition: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the acquisition' do
      acquisition
      expect do
        delete :destroy, params: { id: acquisition.id }
      end.to change(Acquisition, :count).by(-1)
    end

    it 'redirects to categories path with a notice' do
      delete :destroy, params: { id: acquisition.id }
      expect(response).to redirect_to(categories_path)
      expect(flash[:notice]).to match(/Transaction was successfully deleted./)
    end
  end
end
