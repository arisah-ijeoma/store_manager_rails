module ApplicationHelper
  def alert_color(name)
    case name
      when "notice" then "success"
      when "alert" then "danger"
      else name
    end
  end
end
