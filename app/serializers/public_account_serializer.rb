class PublicAccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :tp, :image, :body, :menus

  has_many :rules
  belongs_to :user

  attribute :weixin_secret_key, :key => :title

  def body
    object.user.email.downcase
  end
end
