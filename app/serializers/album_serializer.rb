class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :album, :genre, :year

  belongs_to :artist

  def display
    object.display
  end
end
