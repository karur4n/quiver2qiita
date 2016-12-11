# frozen_string_literal: true
require 'quiver2qiita/commands/sync'

module Quiver2qiita
  class CLI
    def initialize(argv)
      @argv = argv
    end

    def start
      case command_name
      when nil
        abort 'ERROR'
      when 'sync'
        sync
      else
        abort 'ERROR'
      end
    end

    def command_name
      @argv.first
    end

    def sync
      Commands::Sync.new.run
    end
  end
end
