# frozen_string_literal: true
require 'quiver2qiita/cells/base'

module Quiver2qiita
  module Cells
    class Unsupported < Base
      def is_supported?
        false
      end
    end
  end
end
