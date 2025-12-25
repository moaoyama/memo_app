require "pagy"

class ApplicationController < ActionController::Base
  include Pagy::Backend
end
