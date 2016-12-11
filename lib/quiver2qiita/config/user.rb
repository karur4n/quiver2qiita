# frozen_string_literal: true
require 'quiver2qiita/config/base'

module Quiver2qiita
  module Config
    class User < Base
      def path
        HOME_PATH + '/user.yml'
      end
    end
  end
end
