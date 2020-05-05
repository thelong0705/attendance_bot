require 'thor'
require 'attendance_bot'


module AttendanceBot
  class CLI < Thor
    desc 'checkin', 'checkin with current time'
    def checkin
      AttendanceBot::Bot.checkin
    end
  end
end