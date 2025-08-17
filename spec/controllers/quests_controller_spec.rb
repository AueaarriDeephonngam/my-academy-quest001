require 'rails_helper'

RSpec.describe QuestsController, type: :controller do
  describe "GET #index" do
    let!(:quest1) { create(:quest, title: "First quest", created_at: 1.day.ago) }
    let!(:quest2) { create(:quest, title: "Second quest", created_at: 2.hours.ago) }
    let!(:quest3) { create(:quest, :completed, title: "Completed quest", created_at: 3.days.ago) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @quests in descending order by created_at" do
      get :index
      expect(assigns(:quests)).to eq([quest2, quest1, quest3])
    end

    it "assigns a new @quest" do
      get :index
      expect(assigns(:quest)).to be_a_new(Quest)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { { title: "New quest title" } }

      it "creates a new Quest" do
        expect {
          post :create, params: { quest: valid_attributes }
        }.to change(Quest, :count).by(1)
      end

      it "redirects to quests_path" do
        post :create, params: { quest: valid_attributes }
        expect(response).to redirect_to(quests_path)
      end

      it "sets a success notice" do
        post :create, params: { quest: valid_attributes }
        expect(flash[:notice]).to eq('Quest added successfully!')
      end

      it "creates quest with correct attributes" do
        post :create, params: { quest: valid_attributes }
        created_quest = Quest.last
        expect(created_quest.title).to eq("New quest title")
        expect(created_quest.done).to be_falsey
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { title: "" } }
      let!(:existing_quest) { create(:quest) }

      it "does not create a new Quest" do
        expect {
          post :create, params: { quest: invalid_attributes }
        }.not_to change(Quest, :count)
      end

      it "renders the index template" do
        post :create, params: { quest: invalid_attributes }
        expect(response).to render_template(:index)
      end

      it "assigns @quests for the view" do
        post :create, params: { quest: invalid_attributes }
        expect(assigns(:quests)).to eq([existing_quest])
      end

      it "assigns the quest with errors to @quest" do
        post :create, params: { quest: invalid_attributes }
        expect(assigns(:quest)).to be_a(Quest)
        expect(assigns(:quest)).to have_attributes(title: "")
        expect(assigns(:quest).errors).not_to be_empty
      end
    end
  end

  describe "PATCH #toggle" do
    let(:quest) { create(:quest, done: false) }

    it "toggles the quest's done status from false to true" do
      patch :toggle, params: { id: quest.id }
      quest.reload
      expect(quest.done).to be_truthy
    end

    it "toggles the quest's done status from true to false" do
      quest.update(done: true)
      patch :toggle, params: { id: quest.id }
      quest.reload
      expect(quest.done).to be_falsey
    end

    it "redirects to quests_path" do
      patch :toggle, params: { id: quest.id }
      expect(response).to redirect_to(quests_path)
    end

    context "with non-existent quest" do
      it "raises ActiveRecord::RecordNotFound" do
        expect {
          patch :toggle, params: { id: 999999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:quest) { create(:quest) }

    it "destroys the requested quest" do
      expect {
        delete :destroy, params: { id: quest.id }
      }.to change(Quest, :count).by(-1)
    end

    it "redirects to quests_path" do
      delete :destroy, params: { id: quest.id }
      expect(response).to redirect_to(quests_path)
    end

    it "sets a success notice" do
      delete :destroy, params: { id: quest.id }
      expect(flash[:notice]).to eq('Quest deleted successfully!')
    end

    context "with non-existent quest" do
      it "raises ActiveRecord::RecordNotFound" do
        expect {
          delete :destroy, params: { id: 999999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "private methods" do
    describe "#set_quest" do
      let(:quest) { create(:quest) }

      context "when quest exists" do
        it "sets @quest instance variable" do
          patch :toggle, params: { id: quest.id }
          expect(assigns(:quest)).to eq(quest)
        end
      end

      context "when quest doesn't exist" do
        it "raises ActiveRecord::RecordNotFound" do
          expect {
            patch :toggle, params: { id: 999999 }
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe "#quest_params" do
      it "permits only title parameter" do
        # This is tested implicitly in the create action tests
        # but we can also test parameter filtering directly
        post :create, params: { 
          quest: { 
            title: "Test title", 
            done: true,  # This should be filtered out
            some_other_param: "hack attempt"  # This should be filtered out
          } 
        }
        
        created_quest = Quest.last
        expect(created_quest.title).to eq("Test title")
        expect(created_quest.done).to be_falsey  # Should be false by default, not true from params
      end
    end
  end

  # Additional edge case tests
  describe "edge cases" do
    context "when creating quest with whitespace only title" do
      it "fails validation" do
        expect {
          post :create, params: { quest: { title: "   " } }
        }.not_to change(Quest, :count)
      end
    end

    context "when toggling quest multiple times quickly" do
      let(:quest) { create(:quest, done: false) }

      it "handles multiple toggles correctly" do
        # First toggle: false -> true
        patch :toggle, params: { id: quest.id }
        quest.reload
        expect(quest.done).to be_truthy

        # Second toggle: true -> false  
        patch :toggle, params: { id: quest.id }
        quest.reload
        expect(quest.done).to be_falsey

        # Third toggle: false -> true
        patch :toggle, params: { id: quest.id }
        quest.reload
        expect(quest.done).to be_truthy
      end
    end
  end
end
