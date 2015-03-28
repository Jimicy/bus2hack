class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :passport_expiry_date
      t.text :confirmed_emails, array: true, default: []
      t.text :unconfirmed_emails, array: true, default: []

      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :hackathons do |t|
      t.belongs_to :bus, index: true
      t.string :name
      t.datetime :date
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :hackathon_statuses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :hackathon, index: true
      t.string :status
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :buses do |t|
      t.string :name
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end
end
