module Concerns
  module Taxable
    extend ActiveSupport::Concern

    BASIC_PERCENTAGE = 0.1
    IMPORT_PERCENTAGE = 0.05

    def sales_tax_rate
      basic_tax_rate + import_tax_rate
    end

    def basic_tax_rate
      try(:tax_exempted) ? 0 : BASIC_PERCENTAGE
    end

    def import_tax_rate
      try(:type) != 'ImportedProduct' ? 0 : IMPORT_PERCENTAGE
    end
  end
end
