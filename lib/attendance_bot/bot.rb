require 'mechanize'
require 'pry'
require 'config'

module AttendanceBot
  class Bot
    attr_accessor :agent

    def initialize
      @agent = Mechanize.new
      path_to_config = File.dirname(__FILE__) + '/config/config.yml'
      Config.load_and_set_settings(path_to_config)
    end

    def login
      page = agent.get(Settings.login_url)
      login_form = page.form(action: '/employee_session')

      office_field = login_form.fields.find { |f| f.name == 'employee_session_form[office_account_name]' }
      email_field = login_form.fields.find { |f| f.name == 'employee_session_form[account_name_or_email]' }
      password_field = login_form.fields.find { |f| f.name == 'employee_session_form[password]' }

      office_field.value = Settings.office
      email_field.value = Settings.email
      password_field.value = Settings.password

      login_form.submit
    end

    def checkin
      page = login
      clock_in_form = page.forms.first
      user_time = clock_in_form.fields.find { |f| f.name == 'web_time_recorder_form[user_time]' }
      user_time.value = Time.now.to_s

      clock_in_form.submit
    end

    def checkout
      page = login
      clock_out_form = page.forms[1]
      user_time = clock_out_form.fields.find { |f| f.name == 'web_time_recorder_form[user_time]' }
      user_time.value = Time.now.to_s

      clock_out_form.submit
    end
  end
end
