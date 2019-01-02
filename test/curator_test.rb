require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'csv'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test

  def setup
    @photo_1_attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    @photo_2_attributes = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    @photo_3_attributes = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    @photo_4_attributes = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }

    @artist_1_attributes = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    @artist_2_attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    @artist_3_attributes = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    @photo_1 = Photograph.new(@photo_1_attributes)
    @photo_2 = Photograph.new(@photo_2_attributes)
    @photo_3 = Photograph.new(@photo_3_attributes)
    @photo_4 = Photograph.new(@photo_4_attributes)

    @artist_1 = Artist.new(@artist_1_attributes)
    @artist_2 = Artist.new(@artist_2_attributes)
    @artist_3 = Artist.new(@artist_3_attributes)

    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_starts_with_no_artists
    assert_equal [], @curator.artists
  end

  def test_it_starts_with_no_photographs
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal [@photo_1, @photo_2], @curator.photographs
  end

  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_can_find_artists_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
  end

  def test_it_can_find_photos_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@photo_3, @photo_4], @curator.find_photographs_by_artist(@artist_3)
  end

  def test_it_can_find_artists_with_multiple_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
  end

  def test_it_can_find_photos_taken_by_artists_from_a_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    expected = [@photo_2, @photo_3, @photo_4]
    assert_equal expected, @curator.photographs_taken_by_artist_from("United States")
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end

  def test_it_can_load_photos
    @curator.load_photographs('./data/photographs.csv')

    all_photos = @curator.photographs.all? do |photo|
      photo.class == Photograph
    end

    assert_equal true, all_photos
    assert_equal 4, @curator.photographs.length
  end

  def test_it_can_load_artists
    @curator.load_artists('./data/artists.csv')

    all_artists = @curator.artists.all? do |artist|
      artist.class == Artist
    end

    assert_equal true, all_artists
    assert_equal 3, @curator.artists.length
  end
end
