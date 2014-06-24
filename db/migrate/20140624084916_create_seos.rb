class CreateSeos < ActiveRecord::Migration
  def change
    create_table :seos do |t|
      t.string :title
      t.string :description
      t.string :keywords
      t.text :url
      t.string :seoable_type
      t.integer :seoable_id
      t.text :text

      t.timestamps
    end

    add_index :seos, :seoable_type
    add_index :seos, :seoable_id
    add_index :seos, :url
  end
end
