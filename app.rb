require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/database_connection'

class Application

  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "\n"
    @io.puts "Welcome to the music library manager!"
    @io.puts "\n"
    @io.puts "What would you like to do?"
    @io.puts "1 - List all albums"
    @io.puts "2 - List all artists"
    @io.puts "\n"
    @io.puts "Enter your choice:"

    selection = @io.gets.chomp

    if selection == "1"
      @io.puts "Here is the list of albums:"
      @album_repository.all.each { |record|
        @io.puts "* #{record.id} - #{record.title}"
      }
    else
      @io.puts "Here is the list of artists:"
      @artist_repository.all.each { |record|
        @io.puts "* #{record.id} - #{record.name}"
      } 
    end
  end
end


if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end