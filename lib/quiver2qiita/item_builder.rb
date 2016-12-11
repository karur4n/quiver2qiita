# frozen_string_literal: true

require 'quiver2qiita/user_config'

module Quiver2qiita
  class ItemBuilder
    class << self
      def build(note)
        @note = note
        @item = {}

        build_body
        build_tags
        build_title
        build_by_user_config

        @item
      end

      private

      def build_body
        body = ''
        @note.cells.each do |cell|
          case cell.type
          when 'markdown'
            body += cell.content + "\n\n"
          when 'code'
            body += cell.content + "\n\n"
          end
        end
        @item[:body] = body
      end

      def build_by_user_config
        config = UserConfig.new

        @item.merge!({ tweet: config.tweet })
      end

      def build_tags
        tags = @note.tags.map { |tag| { name: tag } }
        @item[:tags] = [{ name: @note.notebook_name }].concat(tags)
      end

      def build_title
        @item[:title] = @note.title
      end
    end
  end
end
