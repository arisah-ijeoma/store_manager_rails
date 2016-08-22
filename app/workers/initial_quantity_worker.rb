class InitialQuantityWorker
  include Sidekiq::Worker

  def perform(item_id)
    item = Item.find(item_id)
    item.update_attribute(:initial_quantity, item.quantity)
  end
end
