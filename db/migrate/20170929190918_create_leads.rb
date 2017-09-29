class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :name, index: true
      t.string :company, index: true
      t.string :phone, index: true
      t.string :mobile, index: true
      t.string :lead_source

      t.timestamps
    end
  end
end
