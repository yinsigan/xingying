class AddSubjectableToKwords < ActiveRecord::Migration
  def change
    add_reference :kwords, :subjectable, polymorphic: true, index: true
  end
end
