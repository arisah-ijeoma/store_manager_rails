class ItemDecorator
  def initialize(items)
    @items = items
  end

  def order_pattern(sort_by, q)
    if q.present?
      @items.search_items(q)
    elsif sort_by == 'category'
      Item.order(:category)
    elsif sort_by == 'brand'
      Item.order(:brand)
    elsif sort_by == 'name'
      Item.order(:name)
    else
      @items
    end
  end
end
