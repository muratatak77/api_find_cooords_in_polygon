module Geokit
  class LatLng
    # include Mappable

    attr_accessor :lat, :lng

    # Provide users with the ability to use :latitude and :longitude
    # to access the lat/lng instance variables.
    # Alias the attr_accessor :lat to :latitude
    alias_method :latitude, :lat
    alias_method :latitude=, :lat=
    # Alias the attr_accessor :lng to :longitude
    alias_method :longitude, :lng
    alias_method :longitude=, :lng=

    # Accepts latitude and longitude or instantiates an empty instance
    # if lat and lng are not provided. Converted to floats if provided
    def initialize(lat = nil, lng = nil)
      lat = lat.to_f if lat && !lat.is_a?(Numeric)
      lng = lng.to_f if lng && !lng.is_a?(Numeric)
      @lat = lat
      @lng = lng
    end

    def self.from_json(json)
      new(json['lat'], json['lng'])
    end

    # Latitude attribute setter; stored as a float.
    def lat=(lat)
      @lat = lat.to_f if lat
    end

    # Longitude attribute setter; stored as a float;
    def lng=(lng)
      @lng = lng.to_f if lng
    end

    # Returns the lat and lng attributes as a comma-separated string.
    def ll
      "#{lat},#{lng}"
    end

    # returns latitude as [ degree, minute, second ] array
    def lat_dms
      self.class.decimal_to_dms(lat)
    end

    # returns longitude as [ degree, minute, second ] array
    def lng_dms
      self.class.decimal_to_dms(lng)
    end

    # returns a string with comma-separated lat,lng values
    def to_s
      ll
    end

    # returns a two-element array
    def to_a
      [lat, lng]
    end

    # Returns true if the candidate object is logically equal. Logical
    # equivalence is true if the lat and lng attributes are the same for both
    # objects.
    def ==(other)
      return false unless other.is_a?(LatLng)
      lat == other.lat && lng == other.lng
    end

    def hash
      lat.hash + lng.hash
    end

    def eql?(other)
      self == other
    end

    # Returns true if both lat and lng attributes are defined
    def valid?
      lat && lng
    end
   
  end
end
