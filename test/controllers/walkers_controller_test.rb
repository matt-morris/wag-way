require 'test_helper'

class WalkersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @walker1 = walkers(:one)
    @walker2 = walkers(:two)
  end

  test 'should return nearby walkers with suitable availability' do
    # Assume there is a matching availability for @walker1 in fixtures
    # Assume there is no matching availability for @walker2 in fixtures
    latitude, longitude = [39.742043, -104.991531]  # denver
    start_at = '2023-09-14 12:30:00'
    duration = 60  # 1 hour

    # Perform the search
    get walkers_url, params: {
      latitude: latitude,
      longitude: longitude,
      start_at: start_at,
      duration: duration
    }
    assert_response :success

    json_response = JSON.parse(@response.body)

    assert_includes json_response['walkers'].map { |w| w['id'] }, @walker1.id
    refute_includes json_response['walkers'].map { |w| w['id'] }, @walker2.id
  end

  test 'should not return walkers with conflicting walks' do
    # Assume there is a conflicting walk for @walker1 in fixtures
    latitude, longitude = [39.742, -104.60]  # denver
    start_at = '2023-10-01 10:00:00'  # Same start time as the conflicting walk
    duration = 60  # 1 hour

    # Perform the search
    get walkers_url, params: {
      latitude: latitude,
      longitude: longitude,
      start_at: start_at,
      duration: duration
    }
    assert_response :success

    json_response = JSON.parse(@response.body)

    refute_includes json_response['walkers'].map { |w| w['id'] }, @walker1.id
  end
end
