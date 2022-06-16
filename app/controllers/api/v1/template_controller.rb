class Api::V1::TemplateController < ApplicationController

  def create
    @plaintext = params['plaintext']
    if @plaintext.present?
      @test = AddTagsValuesIntoTextService.new(@plaintext)
      @plaintexts= @test.get_document
      @error_message=@test.get_error_message
    else
      @error_message='plaintext not found'
    end
    if @error_message.blank?
      render json: { plaintext: @plaintexts }, status: :ok
    else
      render json: { error: @error_message }, status: :not_found
    end
  end

end