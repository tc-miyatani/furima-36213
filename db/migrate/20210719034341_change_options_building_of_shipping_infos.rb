class ChangeOptionsBuildingOfShippingInfos < ActiveRecord::Migration[6.0]
  def change
    change_column_null :shipping_infos, :building, true
    change_column_default :shipping_infos, :building, from: '', to: nil
  end
end
