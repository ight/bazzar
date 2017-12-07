class Api::V1::ItemsController < ApplicationController

	swagger_controller :items, "Handle Item Actions"

  swagger_api :create do
  	summery 'Add an Item to Bazzar'
  end
end