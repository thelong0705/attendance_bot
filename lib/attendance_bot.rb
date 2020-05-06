# frozen_string_literal: true

require 'mechanize'
require 'rubygems'
require 'pry'
require 'attendance_bot/version'
require 'config'

module AttendanceBot
  class Error < StandardError; end
  # Your code goes here...
  class Bot
    def self.checkin
      agent = Mechanize.new
      page = agent.get('https://attendance.moneyforward.com/employee_session/new')
      login_form = page.form(action: '/employee_session')

      office_field = login_form.fields.find { |f| f.name == 'employee_session_form[office_account_name]' }
      email_field = login_form.fields.find { |f| f.name == 'employee_session_form[account_name_or_email]' }
      password_field = login_form.fields.find { |f| f.name == 'employee_session_form[password]' }

      Config.load_and_set_settings('./config/config.yml')

      office_field.value = Settings.office
      email_field.value = Settings.email
      password_field.value = Settings.password


      page = agent.submit(login_form)


      clock_in_form = page.forms.first
      user_time = clock_in_form.fields.find{ |f| f.name == 'web_time_recorder_form[user_time]' }
      user_time.value = Time.now.to_s

      clock_in_form.submit
    end

    def self.checkout
      #TODO: refactor code
      agent = Mechanize.new
      page = agent.get('https://attendance.moneyforward.com/employee_session/new')
      login_form = page.form(action: '/employee_session')

      office_field = login_form.fields.find { |f| f.name == 'employee_session_form[office_account_name]' }
      email_field = login_form.fields.find { |f| f.name == 'employee_session_form[account_name_or_email]' }
      password_field = login_form.fields.find { |f| f.name == 'employee_session_form[password]' }

      Config.load_and_set_settings('./config/config.yml')

      office_field.value = Settings.office
      email_field.value = Settings.email
      password_field.value = Settings.password
      page = agent.submit(login_form)

      clock_out_form = page.forms[1]
      user_time = clock_out_form.fields.find{ |f| f.name == 'web_time_recorder_form[user_time]' }
      user_time.value = Time.now.to_s

      clock_out_form.submit
    end
  end
end
