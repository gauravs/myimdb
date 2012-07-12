require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/myimdb"

class TestGoogle < Test::Unit::TestCase

  def setup
    ## Nothing really
  end

  def teardown
    ## Nothing really
  end

  def search(movie_name)
    Myimdb::Search::Bing.search(movie_name, :restrict_to=> "imdb.com")
  end


  def test_search_movie
    search_result = search("The Dark Knight")

    assert_equal(search_result.first[:url], "http://www.imdb.com/title/tt0468569/")
    assert_equal(search_result.first[:title], "The Dark Knight (2008) - IMDb")
  end

end