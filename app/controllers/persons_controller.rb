class PersonsController < ApplicationController
  def show
    @person = Person.find params[:id]
    render layout: "person"
  end
end
