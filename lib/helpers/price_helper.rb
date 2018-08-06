module Helpers
  class PriceHelper
    DEFAULT_ROUND_TO_NEAREST = 0.05
    DEFAULT_DISPLAYED_DIGITS = 2

    def self.round(amount, round_to_nearest = DEFAULT_ROUND_TO_NEAREST)
      scale = 1 / round_to_nearest
      (amount * scale).ceil / scale
    end

    def self.display(amount, number_of_digits = DEFAULT_DISPLAYED_DIGITS)
      format("%.#{number_of_digits}f", amount)
    end
  end
end
