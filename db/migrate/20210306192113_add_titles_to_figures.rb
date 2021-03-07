class AddTitlesToFigures < ActiveRecord::Migration
  def change
    add_column :figures, :title, :string
  end
end
