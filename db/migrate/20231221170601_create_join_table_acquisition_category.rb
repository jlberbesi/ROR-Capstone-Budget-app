class CreateJoinTableAcquisitionCategory < ActiveRecord::Migration[6.0]
  def change
    create_join_table :acquisitions, :categories do |t|
      # t.index [:acquisition_id, :category_id]
      # t.index [:category_id, :acquisition_id]
    end
  end
end
