class AddLanguageToPerson < ActiveRecord::Migration
  def change
    add_column :people, :language, :string
  end
end
