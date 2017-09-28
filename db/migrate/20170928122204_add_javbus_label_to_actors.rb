class AddJavbusLabelToActors < ActiveRecord::Migration[5.0]
  def change
    add_column :actors, :javbus_label, :string
  end
end
