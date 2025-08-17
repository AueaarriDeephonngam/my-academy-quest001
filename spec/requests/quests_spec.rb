require 'rails_helper'

RSpec.describe "Quests", type: :request do
  describe "GET /quests" do
    let!(:quest1) { create(:quest, title: "First quest", created_at: 1.day.ago) }
    let!(:quest2) { create(:quest, title: "Second quest", created_at: 2.hours.ago) }

    it "returns http success" do
      get "/quests"
      expect(response).to have_http_status(200)
    end

    it "displays the quest form" do
      get "/quests"
      expect(response.body).to include('form')
      expect(response.body).to include('Add new quest...')
    end

    it "displays existing quests" do
      get "/quests"
      expect(response.body).to include(quest1.title)
      expect(response.body).to include(quest2.title)
    end
  end

  describe "POST /quests" do
    context "with valid parameters" do
      it "creates a quest and redirects" do
        expect {
          post "/quests", params: { quest: { title: "New quest from request spec" } }
        }.to change(Quest, :count).by(1)
        
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/quests")
      end

      it "creates quest with correct title" do
        post "/quests", params: { quest: { title: "Test Quest Title" } }
        expect(Quest.last.title).to eq("Test Quest Title")
      end
    end

    context "with invalid parameters" do
      it "does not create a quest" do
        expect {
          post "/quests", params: { quest: { title: "" } }
        }.not_to change(Quest, :count)
      end

      it "returns success status (renders form again)" do
        post "/quests", params: { quest: { title: "" } }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "PATCH /quests/:id/toggle" do
    let(:quest) { create(:quest, done: false) }

    it "toggles quest completion status" do
      patch "/quests/#{quest.id}/toggle"
      quest.reload
      expect(quest.done).to be_truthy
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/quests")
    end
  end

  describe "DELETE /quests/:id" do
    let!(:quest) { create(:quest) }

    it "deletes the quest" do
      expect {
        delete "/quests/#{quest.id}"
      }.to change(Quest, :count).by(-1)
      
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/quests")
    end
  end

  # Integration test for complete user workflow
  describe "complete user workflow" do
    it "allows creating, toggling, and deleting quests" do
      # Start with no quests
      expect(Quest.count).to eq(0)
      
      # Create a quest
      post "/quests", params: { quest: { title: "Learn RSpec testing" } }
      expect(Quest.count).to eq(1)
      quest = Quest.last
      expect(quest.title).to eq("Learn RSpec testing")
      expect(quest.done).to be_falsey
      
      # Toggle quest to completed
      patch "/quests/#{quest.id}/toggle"
      quest.reload
      expect(quest.done).to be_truthy
      
      # Toggle quest back to pending
      patch "/quests/#{quest.id}/toggle"
      quest.reload
      expect(quest.done).to be_falsey
      
      # Delete the quest
      delete "/quests/#{quest.id}"
      expect(Quest.count).to eq(0)
    end
  end
end
