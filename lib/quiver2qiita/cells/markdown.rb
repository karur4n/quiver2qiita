require 'quiver2qiita/cells/base'

module Quiver2qiita
  module Cells
    class Markdown < Base
      def content
        @cell['data']
      end

      def is_supported?
        true
      end
    end
  end
end
