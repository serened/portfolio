# This is an example from an interview that provided a passing test to develop against. It is a low-budget version of Yahtzee.

class Yatzy
  
  def initialize(d1, d2, d3, d4, d5)
    @dice = [ d1, d2, d3, d4, d5 ].sort.reverse
  end

  def chance
    @dice.inject(&:+)
  end

  def yatzy
    of_a_kind(5).zero? ? default_score : 50
  end

  def ones
    dice_summation_by_value(1) 
  end

  def twos
    dice_summation_by_value(2) 
  end

  def threes
    dice_summation_by_value(3) 
  end

  def fours
    dice_summation_by_value(4) 
  end

  def fives
    dice_summation_by_value(5) 
  end

  def sixes
    dice_summation_by_value(6) 
  end

  def score_pair
    return_set(2) * 2
  end

  def two_pair
    result = @dice.select{ |e| @dice.count(e) > 1 }.uniq
    score = 0
    result.each {|i| score += i * 2 } unless result.size <= 1
    score
  end

  def four_of_a_kind
    of_a_kind(4) * 4
  end

  def three_of_a_kind
    of_a_kind(3) * 3
  end

  def small_straight
    return default_score if highest_dice == 6

    detect_straight? ? 15 : default_score 
  end

  def large_straight
    return default_score unless highest_dice == 6

    detect_straight? ? 20 : default_score 
  end

  def full_house
    pair = return_set(2)
    trio = return_set(3)

    if ( pair.zero? || trio.zero? )
      default_score
    else
      pair * 2 + trio * 3
    end
  end

private
  def default_score
    0
  end

  def highest_dice
    @dice[0]
  end

  def return_set(value)
    set = @dice.detect{ |e| @dice.count(e) == value }
    set.nil? ? default_score : set
  end

  def detect_straight?
    result = 0
    @dice.each_cons(2){ |a,b| result +=1 if b.succ == a }
    result == 4
  end

  def dice_summation_by_value(value)
    @dice.select{|i| i == value}.inject(&:+) || default_score
  end

  def of_a_kind(value)
    result = @dice.find{ |e| @dice.count(e) >= value }

    result.nil? ? 0 : result
  end
end
