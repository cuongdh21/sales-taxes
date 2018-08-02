module Helpers
  class PriceHelper
    DEFAULT_ROUNDED_DIGITS = 2
    DEFAULT_DISPLAYED_DIGITS = 2

    def self.round(amount, number_of_digits = DEFAULT_ROUNDED_DIGITS)
      amount.round(number_of_digits)
    end

    def self.display(amount, number_of_digits = DEFAULT_DISPLAYED_DIGITS)
      format("%.#{number_of_digits}f", amount)
    end
  end
end
