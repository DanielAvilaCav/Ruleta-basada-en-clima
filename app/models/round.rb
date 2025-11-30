class Round < ApplicationRecord
  belongs_to :player

  def self.spin_wheel
    rand_num = rand(100)
    case rand_num
    when 0..1 then 'Verde'
    when 2..50 then 'Rojo'
    else 'Negro'
    end
  end

  def calculate_winnings
    return 0 if wheel_result != bet_color
    
    case bet_color
    when 'Verde' then bet_amount * 15
    when 'Rojo', 'Negro' then bet_amount * 2
    else 0
    end
  end
end
