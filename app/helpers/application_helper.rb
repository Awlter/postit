module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %I:%M%P %Z")
  end
end
