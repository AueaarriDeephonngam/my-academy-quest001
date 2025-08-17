require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe "validations" do
    it "is valid with a title" do
      quest = build(:quest, title: "Learn RSpec")
      expect(quest).to be_valid
    end

    it "is invalid without a title" do
      quest = build(:quest, title: nil)
      expect(quest).not_to be_valid
      expect(quest.errors[:title]).to include("can't be blank")
    end

    it "is invalid with an empty title" do
      quest = build(:quest, title: "")
      expect(quest).not_to be_valid
      expect(quest.errors[:title]).to include("can't be blank")
    end

    it "is invalid with a title that is too short" do
      quest = build(:quest, title: "")
      expect(quest).not_to be_valid
      expect(quest.errors[:title]).to include("is too short (minimum is 1 character)")
    end

    it "is valid with a single character title" do
      quest = build(:quest, title: "A")
      expect(quest).to be_valid
    end

    it "is valid with a long title" do
      long_title = "A" * 1000
      quest = build(:quest, title: long_title)
      expect(quest).to be_valid
    end
  end

  describe "default values" do
    it "sets done to false by default" do
      quest = create(:quest)
      expect(quest.done).to be_falsey
    end

    it "can be created as completed" do
      quest = create(:quest, :completed)
      expect(quest.done).to be_truthy
    end
  end

  describe "scopes" do
    let!(:completed_quest1) { create(:quest, :completed, title: "Completed 1") }
    let!(:completed_quest2) { create(:quest, :completed, title: "Completed 2") }
    let!(:pending_quest1) { create(:quest, title: "Pending 1") }
    let!(:pending_quest2) { create(:quest, title: "Pending 2") }

    describe ".completed" do
      it "returns only completed quests" do
        completed_quests = Quest.completed
        expect(completed_quests).to contain_exactly(completed_quest1, completed_quest2)
      end

      it "returns empty collection when no completed quests exist" do
        Quest.destroy_all
        create(:quest, done: false)
        expect(Quest.completed).to be_empty
      end
    end

    describe ".pending" do
      it "returns only pending quests" do
        pending_quests = Quest.pending
        expect(pending_quests).to contain_exactly(pending_quest1, pending_quest2)
      end

      it "returns empty collection when no pending quests exist" do
        Quest.destroy_all
        create(:quest, :completed)
        expect(Quest.pending).to be_empty
      end
    end
  end

  describe "database constraints" do
    it "persists to database correctly" do
      quest = create(:quest, title: "Test Quest", done: false)
      persisted_quest = Quest.find(quest.id)
      
      expect(persisted_quest.title).to eq("Test Quest")
      expect(persisted_quest.done).to be_falsey
      expect(persisted_quest.created_at).to be_present
      expect(persisted_quest.updated_at).to be_present
    end

    it "updates timestamps on save" do
      quest = create(:quest)
      original_updated_at = quest.updated_at
      
      sleep(0.01) # Small delay to ensure timestamp difference
      quest.update(title: "Updated title")
      
      expect(quest.updated_at).to be > original_updated_at
    end
  end

  describe "factory" do
    it "creates valid quest with factory" do
      quest = create(:quest)
      expect(quest).to be_persisted
      expect(quest).to be_valid
    end

    it "creates completed quest with trait" do
      quest = create(:quest, :completed)
      expect(quest.done).to be_truthy
    end

    it "creates quest with long title trait" do
      quest = create(:quest, :with_long_title)
      expect(quest.title.length).to be > 50
    end
  end

  describe "edge cases" do
    it "handles whitespace in title correctly" do
      quest = build(:quest, title: "   ")
      expect(quest).not_to be_valid
    end

    it "preserves whitespace in valid titles" do
      quest = create(:quest, title: "  My Quest  ")
      expect(quest.title).to eq("  My Quest  ")
    end

    it "handles special characters in title" do
      special_title = "Quest with émojis 🎯 and spëcial chârs!"
      quest = create(:quest, title: special_title)
      expect(quest.title).to eq(special_title)
    end

    it "can toggle done status multiple times" do
      quest = create(:quest, done: false)
      
      quest.update(done: true)
      expect(quest.done).to be_truthy
      
      quest.update(done: false)
      expect(quest.done).to be_falsey
      
      quest.update(done: true)
      expect(quest.done).to be_truthy
    end
  end
end
