class RoundsController < ApplicationController
  def play
    RoundsService.play_round
    redirect_to players_url, notice: 'Ronda jugada exitosamente.'
  end
end