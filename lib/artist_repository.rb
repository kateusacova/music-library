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
    sql = "SELECT id, name, genre FROM artists WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    
    record = result[0]
    
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']
    
    artist
  end
end
