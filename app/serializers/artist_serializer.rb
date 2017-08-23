class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :albums

  def display
    object.display
  end
  
end
