module Api
  class NamesController < ApplicationController
   
    def index
      @name = Name.choose_name(params[:name].downcase, params[:birth_date].to_date,params[:sex])
      render json: @name
    end

  end
end
