require_relative "../lib/album_repository.rb"

RSpec.describe AlbumRepository do 
  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: ENV['HOST'], dbname: 'music_library_test', user: 'postgres', password: ENV['PASSWORD'] })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_albums_table
  end
  
  it "returns the list of albums" do
    repo = AlbumRepository.new
    albums = repo.all
    expect(albums.length).to eq 2
    expect(albums[0].id).to eq "1"
    expect(albums[0].title).to eq 'Doolittle'
  end
end
