require "google/apis/calendar_v3"
require "googleauth"

class GoogleCalendarService
  CALENDAR_ID = "hijosdecainlalinea@gmail.com"
  KEY_PATH    = Rails.root.join("lib", "service_account.json")
  TIME_ZONE   = "Europe/Madrid"

  def self.events_for_month(date)
    service = build_service
    result = service.list_events(
      CALENDAR_ID,
      max_results: 250,
      single_events: true,
      order_by: "startTime",
      time_min: date.beginning_of_month.to_time.utc.iso8601,
      time_max: date.end_of_month.to_time.utc.iso8601
    )
    result&.items || []
  rescue Google::Apis::Error => e
    Rails.logger.error("GoogleCalendarService error: #{e.message}")
    nil
  end

  def self.create_event(title:, date:, start_time:, end_time:, description: nil, mesas:)
    service = build_service

    desc_parts = []
    desc_parts << description if description.present?
    desc_parts << "Mesas: #{mesas}"

    event = Google::Apis::CalendarV3::Event.new(
      summary: title,
      description: desc_parts.join("\n"),
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: DateTime.parse("#{date}T#{start_time}:00").iso8601,
        time_zone: TIME_ZONE
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: DateTime.parse("#{date}T#{end_time}:00").iso8601,
        time_zone: TIME_ZONE
      )
    )

    service.insert_event(CALENDAR_ID, event)
  rescue Google::Apis::Error => e
    Rails.logger.error("GoogleCalendarService create_event error: #{e.message}")
    nil
  end

  def self.build_service
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(KEY_PATH),
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR
    )
    service
  end
 # private_class_method :build_service
end
