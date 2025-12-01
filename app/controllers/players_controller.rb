class PlayersController < ApplicationController
  before_action :set_player, only: [:edit, :update, :destroy]

def index

    @last_round = Round.order(created_at: :desc).first


    if @last_round.nil? || @last_round.created_at < 3.minutes.ago
  
      RoundsService.play_round
      

      @last_round = Round.order(created_at: :desc).first
    end


    @players = Player.all
    @rounds = Round.includes(:player).order(created_at: :desc).limit(20)
    @weather = WeatherService.new.current_weather
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to players_url, notice: 'Jugador creado.'
    else
      redirect_to players_url, alert: 'Error al crear.'
    end
  end

  def edit; end

  def update
    if @player.update(player_params)
      redirect_to players_url, notice: 'Jugador actualizado.'
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    redirect_to players_url, notice: 'Jugador eliminado.'
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :balance)
  end
end