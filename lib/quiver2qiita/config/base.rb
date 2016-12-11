# frozen_string_literal: true
require 'yaml'

module Quiver2qiita
  module Config
    class Base
      HOME_PATH = File.expand_path('~/.quiver2qiita')

      def initialize
        create_file unless is_exist?
        @content = YAML.load_file(path) || {} # yaml が空のとき return が返るため
      end

      def add(key, value)
        @content[key] = value
      end

      def get(key)
        @content[key]
      end

      def path
        raise NotImplementedError
      end

      def save
        YAML.dump(@content, File.open(path, 'w'))
      end

      private

      def is_exist?
        File.exist?(path)
      end

      def create_file
        File.open(path, 'w') { |file| file.write('') }
      end
    end
  end
end
