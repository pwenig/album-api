module SortCollection

   def self.sort_albums(sort_attr)
    sorted_albums = []
    ranked = {}

    # Get all of the albums and sort them by the sort_attr
    albums = Album.all.sort_by { |k| k["#{sort_attr}"]}

    # Create an array of unique attribute keys
    attribute_keys = albums.map{ |f| f["#{sort_attr}"] }.uniq

    # Iterate through each of the attribute_keys and select the albums that match the attribute
    # Create an array of arrays
    attribute_keys.each do |y|
      sorted_albums.push(albums.select{ |a| a["#{sort_attr}"] == y })
    end 

    # Iterate through sorted_albums and create key/value pairs
    # of sort_attr and the number in each sort_attr (ie "1958"=>1, "Alternative"=>24 )
    sorted_albums.each do |a|
      ranked[a.first["#{sort_attr}"]] = a.length
    end

    ranked
  end 

end

