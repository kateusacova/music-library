require_relative "../lib/artist.rb"
require_relative "../lib/album_repository.rb"

class ArtistRepository
  def all
    result_set = DatabaseConnection.exec_params('SELECT id, name, genre FROM artists;', [])
    
    artists = []

    result_set.each { |record|
      artists << record_to_artist(record)
    }
    
    artists
  end

  def find(id)
    sql = "SELECT id, name, genre FROM artists WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    record_to_artist(result[0])
  end

  def find_with_albums(id)
    sql = "SELECT artists.id AS id,
                  artists.name AS name,
                  artists.genre AS genre,
                  albums.id AS album_id,
                  albums.title AS title,
                  albums.release_year AS release_year
                  FROM artists
                    JOIN albums
                    ON albums.artist_id = artists.id
                    WHERE artists.id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    artist = record_to_artist(result[0])

    result.each { |record|
      artist.albums << record_to_album(record)
    }

    artist
    end

    private

    def record_to_artist(record)
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artist
    end

    def record_to_album(record)
      album = Album.new

      album.id = record["id"]
      album.title = record["title"]
      album.release_year = record["release_year"]
      
      album
    end
end
