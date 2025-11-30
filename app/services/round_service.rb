class RoundsService
  def self.play_round
    weather_service = WeatherService.new
    weather = weather_service.current_weather

    Player.all.each do |player|
      next if player.balance == 0

      bet_amount = player.place_bet(weather[:condition])
      next if bet_amount == 0
      
      bet_color = player.choose_color(weather[:condition])
      wheel_result = Round.spin_wheel
      
      winnings = 0
      result = 'Perdió'

      if wheel_result == bet_color
        result = 'Ganó'
        winnings = (bet_color == 'Verde') ? (bet_amount * 15) : (bet_amount * 2)
      end

      # Actualizar balance: Restamos apuesta, sumamos ganancia
      player.update(balance: player.balance - bet_amount + winnings)

      Round.create(
        player: player,
        bet_color: bet_color,
        bet_amount: bet_amount,
        wheel_result: wheel_result,
        result: result,
        player_winnings: winnings,
        weather_condition: weather[:condition],
        weather_temp: weather[:temperature],
        weather_description: weather[:description]
      )
    end
  end
end