class Player < ApplicationRecord
  has_many :rounds, dependent: :destroy
  validates :name, presence: true
  validates :balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def place_bet(weather_condition = 'Clear')
    return 0 if balance == 0
    
    # Si tiene 1000 o menos, va All In
    if balance <= 1000
      base_bet = balance 
    else
      # Apuesta entre 8% y 15%
      min_bet = (balance * 0.08).to_i
      max_bet = (balance * 0.15).to_i
      base_bet = rand(min_bet..max_bet)
    end

    apply_weather_modifier(base_bet, weather_condition)
  end

  def choose_color(weather_condition = 'Clear')
    probabilities = calculate_color_probabilities(weather_condition)
    rand_num = rand(100)

    case rand_num
    when 0...probabilities[:verde] then 'Verde'
    when probabilities[:verde]...(probabilities[:verde] + probabilities[:rojo]) then 'Rojo'
    else 'Negro'
    end
  end

  private

  def apply_weather_modifier(base_bet, weather_condition)
    modifier = case weather_condition
               when 'Clear', 'Soleado' then 1.0
               when 'Rain', 'Drizzle', 'Thunderstorm', 'Lluvia' then 0.7 
               when 'Snow', 'Nieve' then 0.5 
               when 'Mist', 'Fog', 'Haze', 'Niebla' then 0.85
               else 1.0
               end
    (base_bet * modifier).to_i
  end

  def calculate_color_probabilities(weather_condition)
    case weather_condition
    when 'Clear', 'Soleado'
      { verde: 5, rojo: 47, negro: 48 } 
    when 'Rain', 'Drizzle', 'Thunderstorm', 'Lluvia'
      { verde: 1, rojo: 50, negro: 49 } 
    else
      { verde: 2, rojo: 49, negro: 49 } 
    end
  end
end
