# Albums Model and Repository Classes Design Recipe

## 1. Design and create the Table

## 2. Create Test SQL seeds

## 3. Define the class names

## 4. Implement the Model class

## 5. Define the Repository Class interface

## 6. Write Test Examples

```ruby
# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # =>  2

albums[0].id # =>  1
albums[0].title # =>  'Doolittle'
```

## 7. Reload the SQL seeds before each test run

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
