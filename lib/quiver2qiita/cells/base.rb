# frozen_string_literal: true
module Quiver2qiita
  module Cells
    class Base
      def initialize(cell)
        @cell = cell
      end

      def content
        raise NotImplementedError
      end

      def is_supported?
        raise NotImplementedError
      end

      def type
        @cell['type']
      end
    end
  end
end
