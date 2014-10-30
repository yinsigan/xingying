class AddRuleIdToKwords < ActiveRecord::Migration
  def change
    add_reference :kwords, :rule, index: true
  end
end
