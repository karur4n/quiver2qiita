# frozen_string_literal: true
require 'quiver2qiita/note'

module Quiver2qiita
  class Notebook
    attr_reader :name

    def initialize(path)
      @path = path
      @name = File.basename(path, '.qvnotebook')
    end

    def notes
      Dir.glob(@path + '/*').entries.reject do |path|
        # meta.json を弾く
        File.extname(path) == '.json'
      end.map do |note_path|
        Note.new(note_path, name)
      end
    end
  end
end
