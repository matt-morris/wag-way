require "test_helper"

class WalkerTest < ActiveSupport::TestCase
  def setup
    @walker = Walker.new(
      email: "phi.deaux@doglovers.test",
      first_name: "Fi",
      last_name: "Deaux",
      avatar_url: "https://doglovers.test/phi.deaux.jpg",
      hourly_rate_in_cents: 2500,
      latitude: 40.7128,
      longitude: -74.0060,
      radius: 5
    )
  end

  test "should be valid" do
    assert @walker.valid?
  end

  test "name should be present" do
    @walker.first_name = nil
    assert_not @walker.valid?
  end

  test "price should default to minimum" do
    @walker.hourly_rate_in_cents = nil
    assert @walker.valid?
    assert_equal @walker.hourly_rate_in_cents, Walker::MIN_HOURLY_RATE_IN_CENTS
  end

  test "latitude and longitude should be present" do
    @walker.latitude = nil
    @walker.longitude = nil
    assert_not @walker.valid?
  end

  test "radius should default to minimum" do
    @walker.radius = nil
    assert @walker.valid?
    assert_equal @walker.radius, Walker::DEFAULT_RADIUS_IN_MILES
  end

  test "should have many availabilities" do
    assert_equal @walker.availabilities.build.class, Availability
  end

  test "should have many walks" do
    assert_equal @walker.walks.build.class, Walk
  end
end
