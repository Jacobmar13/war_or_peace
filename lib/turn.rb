require './lib/card'
require './lib/deck'
require './lib/player'

class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      return :basic
    elsif (@player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)) && (@player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2))
      return :mutually_assured_destruction
    elsif (@player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0))
      return :war
    end
  end

  def winner
    if self.type == :basic
      if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
        return @player1
      elsif @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
        return @player2
      end

    elsif self.type == :war
      if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
        return @player1
      elsif @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2)
        return @player2
      end

    elsif self.type == :mutually_assured_destruction
      return 'No Winner'
    end
  end

  def pile_cards
    if self.type == :basic
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    elsif self.type == :war
      3.times do
        @spoils_of_war << player1.deck.remove_card
        @spoils_of_war << player2.deck.remove_card
      end
    else
      3.time do
        player1.deck.remove_card
        player2.deck.remove_card
      end
    end
  end

  def award_spoils
    @spoils_of_war.each do |card|
      winner.deck.add_card(card)
    end
    @spoils_of_war = []
  end
end
