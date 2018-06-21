module CustomersHelper
  def tiers_array_for_select_box
    Tier.all.order(price: :asc).map do |tier|
      ["#{tier.name} - #{number_to_currency(tier.price)} for #{tier.quantity} requests", tier.id]
    end
  end
end
