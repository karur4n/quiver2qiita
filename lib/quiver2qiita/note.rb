require 'json'
require 'quiver2qiita/cells/code'
require 'quiver2qiita/cells/markdown'
require 'quiver2qiita/cells/unsupported'
require 'quiver2qiita/config/history'

module Quiver2qiita
  class Note
    attr_reader :notebook_name

    def initialize(path, notebook_name)
      @path = path
      @notebook_name = notebook_name
      @history = Config::History.new
    end

    def cells
      content['cells'].map do |cell|
        case cell['type']
        when 'code'
          Cells::Code.new(cell)
        when 'markdown'
          Cells::Markdown.new(cell)
        else
          Cells::Unsupported.new(cell)
        end
      end
    end

    def has_unsupported_cell?
      cells.any? do |cell|
        !cell.is_supported?
      end
    end

    def posted?
      !@history.get(uuid).nil?
    end

    def qiita_id
      return nil unless posted?
      @history.get(uuid)[:qiita_id]
    end

    def tags
      meta['tags']
    end

    def title
      content['title']
    end

    def updated?
      history = @history.get(uuid)

      return true unless history
      updated_at > history[:updated_at]
    end

    def updated_at
      meta['updated_at']
    end

    def uuid
      meta['uuid']
    end

    private

    def content
      JSON.parse(File.read(@path + '/content.json'))
    end

    def meta
      JSON.parse(File.read(@path + '/meta.json'))
    end
  end
end
