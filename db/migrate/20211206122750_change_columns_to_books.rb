class ChangeColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :books, :evaluation, false, 0
    change_column_default :books, :evaluation, from: nil, to: 0
  end
end
