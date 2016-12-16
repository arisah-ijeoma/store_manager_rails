module ApplicationHelper
  def alert_color(name)
    case name
      when "notice" then "success"
      when "alert" then "danger"
      else name
    end
  end

  def item_queries(filter, query, sort)
    filter.present? || query.present? || sort.present?
  end
end
