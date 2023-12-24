class ChangeAmountPrecisionInAcquisitions < ActiveRecord::Migration[6.0]
  def change
    change_column :acquisitions, :amount, :decimal, precision: 15, scale: 2
  end
end
