class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :address
      t.date :birth_date
      t.date :churn_date
      t.string :city
      t.string :zip_code
      t.string :phone
      t.string :document_number
      t.string :first_name
      t.string :surnames
      t.date :join_date
      t.string :province
      t.string :user_name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
