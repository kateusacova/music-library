require_relative "../lib/artist.rb"

class ArtistRepository
  def all
    result_set = DatabaseConnection.exec_params('SELECT id, name, genre FROM artists;', [])
    
    artists = []

    result_set.each { |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    }
    
    artists
  end

  def find(id)
    result = DatabaseConnection.exec_params("SELECT id, name, genre FROM artists WHERE id = #{id};", [])
    
    artist = nil
    result.each { |record|
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    artist = artist
    }
  
    artist
  end
end
