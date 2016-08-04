class AddStripeEventIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :stripe_event_id, :string
  end
end
