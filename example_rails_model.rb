# This is an example model from a massive Rails project. It features both math and data modeling.
# I have obfuscated domain logic to preserve the integrity of the project.

class Item < ActiveRecord::Base
  PERCENTAGE  = BigDecimal.new("0.75")

  belongs_to :cool_thing
  belongs_to :not_cool_thing

  scope :available, -> { where(status: "sellable") }
  scope :not_available, -> { where(status: "sold") }

  validates :cool_thing, presence: true

  def clearance!
    update_attributes!(status: "csold", 
                       price_sold: calculate_price_sold)
  end


private

  def calculate_price_sold
    if base_discount_calculation <= cool_thing.minimum_price
      cool_thing.minimum_price
    else
      base_discount_calculation
    end
  end

  def base_discount_calculation
    cool_thing.wholesale_price * PERCENTAGE
  end
end

