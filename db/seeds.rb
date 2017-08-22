require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'albums.csv')).scrub
csv = CSV.parse(csv_text, :headers => true)
artists = []

puts "Creating artists...."
# Create the artists first. Push the artists into an array so we can check for duplicats before creating
csv.each do |row|
  if artists.exclude?(row['artist'])
    Artist.create!(name: row['artist'])
    artists.push(row['artist'])
  end
  
end

puts "Creating albums..."
# Create the albums
csv.each do |row|
  artist = Artist.find_by(name: row['artist'])
  artist.albums.create!(album: row['album'], genre: row['genre'], year: row['year'])
end

puts "Finished!"