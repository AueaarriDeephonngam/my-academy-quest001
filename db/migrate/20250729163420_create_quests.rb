class CreateBragDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :brag_documents do |t|
      t.string :title, null: false
      t.text :content
      t.string :author
      t.integer :read_time, default: 1
      t.timestamps
    end
  end
end