require 'thor/group'
require 'highline'
require 'yaml'
module AttendanceBot
  class Generator < Thor::Group
    include Thor::Actions

    def destination_path
      self.class.source_root + '/config/config.yml'
    end

    def self.source_root
      File.dirname(__FILE__)
    end

    def create_group
      empty_directory('config')
    end

    def copy_config
      template('template_config.yml', destination_path)
    end

    def write_config
      cli = HighLine.new
      email = cli.ask 'Enter your attendance email: '
      password = cli.ask('Enter your password:  ') { |q| q.echo = 'x' }
      config_file = YAML::load_file(destination_path)
      config_file['email'] = email
      config_file['password'] = password
      File.open(destination_path, 'w') { |f| f.write config_file.to_yaml }
    end
  end
end