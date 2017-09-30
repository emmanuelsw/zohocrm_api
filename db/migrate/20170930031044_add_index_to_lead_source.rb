class AddIndexToLeadSource < ActiveRecord::Migration[5.1]
  def change
    add_index :leads, :lead_source
  end
end
