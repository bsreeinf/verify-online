class CreateReportData < ActiveRecord::Migration
  def change
    create_table :report_data do |t|

      t.references :college
      t.string :header_link
      t.string :footer_link
      t.string :signature_link
      t.string :addresser
      t.string :subject
      t.string :body
      

      t.timestamps null: false
    end
  end
end
