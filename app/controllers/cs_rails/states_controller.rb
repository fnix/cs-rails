require_dependency "cs_rails/application_controller"

module CsRails
  class StatesController < ApplicationController
    def index
      @states = ::ISO3166::Country[params[:country_code]].states.map { |k, v| [v['name'], k] }
      @state_input_id = params[:state_input_id]
      respond_to { |format| format.js }
    end
  end
end
