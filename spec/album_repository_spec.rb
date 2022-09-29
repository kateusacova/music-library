require_relative "../lib/album_repository.rb"

def reset_tables
  seed_sql = File.read('spec/seeds_music_library.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: 'music_library_test', user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
  before(:each) do
    reset_tables
  end
  
  it "returns the list of albums" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums[0].id).to eq "1"
    expect(albums[0].title).to eq 'Doolittle'
  end

  it "returns a single Album object" do
    repo = AlbumRepository.new
    album = repo.find(1)
    expect(album.id).to eq "1"
    expect(album.title).to eq 'Doolittle'
  end

  it "create a new Album object with specified parameters" do
    repository = AlbumRepository.new
    album = Album.new
    album.title = 'Trompe le Monde'
    album.release_year = 1991
    album.artist_id = 1
    repository.create(album)
    all_albums = repository.all
    expect(all_albums).to include(
      have_attributes(
        title: album.title,
        release_year: "1991",
        artist_id: "1"
      )
    )
  end
end
