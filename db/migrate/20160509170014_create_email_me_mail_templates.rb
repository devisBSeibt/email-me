class CreateEmailMeMailTemplates < ActiveRecord::Migration
  def change
    create_table :email_me_mail_templates do |t|
      t.string :name
      t.string :description
      t.string :subject
      t.text :content

      t.timestamps null: false
    end
  end
end
