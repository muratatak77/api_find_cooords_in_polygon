require 'test_helper'

class GeofencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @geofence = geofences(:one)
  end

  test "should get index" do
    puts "Testing index"
    get geofences_url, as: :json
    assert_response :success
  end

  test "should create geofence" do
    puts "Testing create"
    assert_difference('Geofence.count') do
      data = { "geofence": { "area_name": @geofence.area_name, "coordinates": @geofence.coordinates } }
      post geofences_url, params: data, as: :json
      res =  JSON.parse(response.body)
      assert_equal @geofence.coordinates, res['coordinates']
    end
    assert_response 201
  end

  test "should show geofence" do
    puts "Testing show"
    get geofence_url(@geofence), as: :json
    assert_response :success
  end

  test "should update geofence" do
    puts "Testing update"
    patch geofence_url(@geofence), params: { geofence: { area_name: @geofence.area_name, coordinates: @geofence.coordinates } }, as: :json
    assert_response 200
  end

  test "should destroy geofence" do
    puts "Testing destroy"
    assert_difference('Geofence.count', -1) do
      delete geofence_url(@geofence), as: :json
    end
    assert_response 204
  end
 
  test "should find_by_coordinate_url geofence" do
    puts "Testing should find geofence"
    data = {}
    data[:id] = @geofence.id
    data[:target_coordinates] = {"lat": 37.7615389, "lng":  -122.4144601}
    post find_by_coordinate_url, params: data, as: :json
    assert_response 200
    res =  JSON.parse(response.body)
    assert_equal @geofence.area_name, res['area_name']
  end


  test "should not find_by_coordinate_url geofence" do
    puts "Testing should find geofence"
    data = {}
    data[:id] = @geofence.id
    data[:target_coordinates] = {"lat": 39.7615389, "lng":  -122.4144601}
    post find_by_coordinate_url, params: data, as: :json
    assert_response 422
  end



end
