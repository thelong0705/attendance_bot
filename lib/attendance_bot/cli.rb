require 'thor'
require 'attendance_bot/bot'
require 'attendance_bot/generator'

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

    desc 'generate', 'Generates a config'
    def generate
      AttendanceBot::Generator.start
    end
  end
end