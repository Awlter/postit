module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end

  def display_datetime(dt)
    if current_user
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("%m/%d/%Y %I:%M%P %Z")
  end
end
