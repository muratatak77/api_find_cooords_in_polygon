
require "#{Rails.root}/lib/geokit/lat_lng.rb"
require "#{Rails.root}/lib/geokit/polygon.rb"

class Geofence < ApplicationRecord

	attr_accessor :lat, :lng

	def find_target_coordinates target_coordinates
		@lat = target_coordinates[:lat]
		@lng = target_coordinates[:lng]
		if contains_point?
			puts "Geofence Model - Success -  We found geofence by lat : #{lat} / lng : #{@lng} in Geofence  [ ID : #{self.id} / coordinated : #{self.coordinates} ] "
			self
		else
			puts "Geofence Model - Warning  -  We did not found geofence by lat : #{lat} / lng : #{@lng} in Geofence  [ ID : #{self.id} / coordinated : #{self.coordinates} ] "
			errors.add(:base, "We did not found geofence.")
			nil
		end
	end

	private

	def contains_point?
		points = []
		self.coordinates.each do |coord|
			points << Geokit::LatLng.new(coord[0], coord[1])
		end
		polygon = Geokit::Polygon.new(points)
		point  = Point.new(@lat, @lng)
		polygon.contains? point
	end

	class Point
		attr_accessor :lat, :lng
		def initialize(lat, lng)
			self.lat = lat.to_f
			self.lng = lng.to_f
		end
	end

end
