require "google/apis/calendar_v3"
require "googleauth"

service = Google::Apis::CalendarV3::CalendarService.new
service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open("service-account.json"),
  scope: Google::Apis::CalendarV3::AUTH_CALENDAR
)

calendar_id = "tu_calendario_id@group.calendar.google.com"
events = service.list_events(calendar_id)

puts events.items.map(&:summary)

