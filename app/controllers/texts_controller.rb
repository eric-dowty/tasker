class TextsController < ApplicationController
  respond_to :json

  def incoming_sms
    TextService.new(params['From'], params['Body']).take_action
  end

end