require "test/unit"
require "#{File.dirname(__FILE__)}/../lib/myimdb"

class TestMyimdb < Test::Unit::TestCase

  def setup
    @movie_name = 'the dark kinght'
    @movie = ImdbMovie.search(@movie_name)
  end

  def teardown
    ## Nothing really
  end

  def test_url
    assert_equal(@movie.instance_variable_get('@url'), "http://www.imdb.com/title/tt0468569/")
  end

  def test_director
    assert_equal(@movie.directors.first, "Christopher Nolan")
  end

  def test_writers
    assert_equal(@movie.writers.first, "Jonathan Nolan")
  end

  def test_rating
    assert_equal(@movie.rating, 8.9)
  end

  def test_votes
    assert_operator(@movie.votes, :>, 725600)
  end

  def test_genres
    assert_equal(@movie.genres.first, "Action")
  end

  def test_tagline
    assert_match(/Why So Serious|I Believe In Harvey Dent/, @movie.tagline)
  end

  def test_plot
    assert_match("Batman raises the stakes in his war on crime", @movie.plot, )
  end

  def test_year
    assert_equal(@movie.year, 2008)
  end

  def test_release_date
    assert_operator(@movie.release_date, :>, Date.parse('1-1-2008'))
  end

  def test_image
    assert_match(/\.jpg$/, @movie.image)
  end

end