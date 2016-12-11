# frozen_string_literal: true
require 'json'

module Quiver2qiita
  class UserConfig
    PATH = File.expand_path('~/.quiver2qiita.json')

    def initialize
      check_exist_file!

      @config = JSON.parse(File.read(PATH))

      check_valid!
    end

    def access_token
      @config['access_token']
    end

    def notebook_paths
      @config['notebook_paths'].map { |path| File.expand_path(path) }
    end

    def tweet
      @config['tweet']
    end

    private

    def check_exist_file!
      return true if File.exist?(PATH)

      abort '設定ファイルが存在しません'
    end

    def check_has_access_token!
      return true if !access_token.nil?

      abort 'access_token をセットしてください'
    end

    def check_valid!
      check_has_access_token!
    end
  end
end
