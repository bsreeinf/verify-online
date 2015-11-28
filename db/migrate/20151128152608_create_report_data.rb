class CreateReportData < ActiveRecord::Migration
  def change
    create_table :report_data do |t|
      t.references :college_id, index: true, foreign_key: true
      t.string :header_link
      t.string :signature_link
      t.text :from_address
      t.text :to_address
      t.string :letter_title
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
  end
end
