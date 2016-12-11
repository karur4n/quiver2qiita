# frozen_string_literal: true
require 'quiver2qiita/cells/base'

module Quiver2qiita
  module Cells
    class Code < Base
      def content
        <<~EOS
        ```#{langage}
        #{data}
        ```
        EOS
      end

      def is_supported?
        true
      end

      private

      def data
        @cell['data']
      end

      def langage
        @cell['language']
      end
    end
  end
end
