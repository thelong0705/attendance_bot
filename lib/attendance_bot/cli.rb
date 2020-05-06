require 'thor'
require 'attendance_bot'


module AttendanceBot
  class CLI < Thor
    def initialize(args = nil, options = nil, config = nil)
      @bot = AttendanceBot::Bot.new
      super
    end

    desc 'checkin', 'checkin with current time'
    def checkin
      @bot.checkin
    end

    desc 'checkout', 'checkout with current time'
    def checkout
      @bot.checkout
    end
  end
end