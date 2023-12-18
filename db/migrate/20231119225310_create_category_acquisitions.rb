class CreateCategoryAcquisitions < ActiveRecord::Migration[7.1]
    def change
      create_table :category_acquisitions do |t|
        t.references :category, null: false, foreign_key: { to_table: :categories }
        t.references :acquisition, null: false, foreign_key: { to_table: :acquisitions }
  
        t.timestamps
      end
    end
  end