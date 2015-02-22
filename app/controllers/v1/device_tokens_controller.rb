module V1
  class DeviceTokensController < ApplicationController
    def create
      head :created
    end
  end
end
