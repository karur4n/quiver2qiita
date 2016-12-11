require 'quiver2qiita/config/base'

module Quiver2qiita
  module Config
    class History < Base
      def path
        HOME_PATH + '/history.yml'
      end
    end
  end
end
