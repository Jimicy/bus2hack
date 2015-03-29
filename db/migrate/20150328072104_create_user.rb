class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :school
      t.datetime :passport_expiry_date
      t.text :confirmed_emails, array: true, default: []
      t.text :unconfirmed_emails, array: true, default: []

      t.string :bus_coordinator
      t.timestamps null: false
    end

    create_table :hackathons do |t|
      t.string :name
      t.datetime :date
      t.timestamps null: false
    end

    create_table :hackathon_statuses do |t|
      t.belongs_to :user, index: true
      t.belongs_to :bus, index: true
      t.string :status
      t.timestamps null: false
    end

    create_table :buses do |t|
      t.belongs_to :hackathon, index: true
      t.string :school
      t.timestamps null: false
    end

  end
end
