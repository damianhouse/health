class AddStripeChargeIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :stripe_charge_id, :string
  end
end
