class SinPicText < ActiveRecord::Base
  belongs_to :thumb
  belongs_to :sin_material, class_name: SinMaterial
  belongs_to :multi_material, class_name: MultiMaterial
end
