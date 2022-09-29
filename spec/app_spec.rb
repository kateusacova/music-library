require_relative "../app.rb"
require_relative "../lib/album_repository.rb"
require_relative "../lib/artist_repository.rb"
require 'dotenv/load'

def reset_tables
  seed_sql = File.read('spec/seeds_music_library.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: 'music_library_test', user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do
    reset_tables
  end

  it "Runs the program" do
    io = double :io
    album_repository = AlbumRepository.new
    artist_repository = double :artist_repository
    app = Application.new("music_library_test", io, album_repository, artist_repository)

    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Welcome to the music library manager!")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all albums")
    expect(io).to receive(:puts).with("2 - List all artists")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Enter your choice:")
    
    expect(io).to receive(:gets).and_return("1")
    
    expect(io).to receive(:puts).with("Here is the list of albums:")
    expect(io).to receive(:puts).with("* 1 - Doolittle")
    expect(io).to receive(:puts).with("* 2 - Surfer Rosa")
    
    app.run
  end

  it "Runs the program" do
    io = double :io
    album_repository = double :album_repository
    artist_repository = ArtistRepository.new
    app = Application.new("music_library_test", io, album_repository, artist_repository)

    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Welcome to the music library manager!")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all albums")
    expect(io).to receive(:puts).with("2 - List all artists")
    expect(io).to receive(:puts).with("\n")
    expect(io).to receive(:puts).with("Enter your choice:")
    
    expect(io).to receive(:gets).and_return("2")
    
    expect(io).to receive(:puts).with("Here is the list of artists:")
    expect(io).to receive(:puts).with("* 1 - Pixies")
    expect(io).to receive(:puts).with("* 2 - ABBA")
    
    app.run
  end
end