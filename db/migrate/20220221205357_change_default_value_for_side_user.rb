class ChangeDefaultValueForSideUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :side, "neutral"
  end
end
