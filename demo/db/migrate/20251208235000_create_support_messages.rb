class CreateSupportMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :support_messages do |t|
      t.string :subject
      t.string :from
      t.string :to
      t.text :body

      t.timestamps
    end
  end
end
