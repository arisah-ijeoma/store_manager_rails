class ItemDecorator
  def initialize(items)
    @items = items
  end

  def list_items(query, sort, filter)
    if query.present?
      item_search(query)
    elsif sort.present? && filter.present?
      order_filtered_items(sort, filter)
    elsif filter.present?
      filter_items(filter)
    elsif sort.present?
      order_pattern(sort)
    else
      @items
    end
  end
  
  private

  def item_search(query)
    @items.search_items(query)
  end

  def order_pattern(sort_by)
    if sort_by == 'category'
      @items.order(:category)
    elsif sort_by == 'brand'
      @items.order(:brand)
    elsif sort_by == 'name'
      @items.order(:name)
    else
      @items
    end
  end

  def order_filtered_items(sort, filter)
    if filter_items(filter).empty?
      @items = []
    elsif sort == 'category'
      filter_items(filter).order(:category)
    elsif sort == 'brand'
      filter_items(filter).order(:brand)
    elsif sort == 'name'
      filter_items(filter).order(:name)
    else
      @items
    end
  end

  def filter_items(cat)
    if available_categories.include?(cat)
      @items.filtered_categories(cat)
    else
      @items = []
    end
  end

  def available_categories
    categories = []
    @items.each do |item|
      categories << item.category
    end

    categories
  end
end
