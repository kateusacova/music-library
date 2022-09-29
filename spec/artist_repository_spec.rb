require_relative "../lib/artist_repository.rb"
require 'dotenv/load'

def reset_tables
  seed_sql = File.read('spec/seeds_music_library.sql')
  connection = PG.connect({ host: ENV['HOST'], dbname: 'music_library_test', user: 'postgres', password: ENV['PASSWORD'] })
  connection.exec(seed_sql)
end

RSpec.describe ArtistRepository do
  before(:each) do
    reset_tables
  end

  it 'returns the list of artists' do
    repo = ArtistRepository.new()
    artists = repo.all
    expect(artists.length).to eq 2
    expect(artists.first.id).to eq '1'
    expect(artists.first.name).to eq 'Pixies'
  end

  it 'returns a single Artist object' do
    repo = ArtistRepository.new()
    artist = repo.find(1)
    expect(artist.id).to eq '1'
    expect(artist.name).to eq 'Pixies'
    expect(artist.genre).to eq 'Rock'
  end

  it "Return an Artist object with an array of Album objects" do
    repo = ArtistRepository.new()
    artist = repo.find_with_albums(1)
    expect(artist.name).to eq "Pixies"
    expect(artist.albums.length).to eq 2
    expect(artist.albums.first.title).to eq "Doolittle"
  end
end