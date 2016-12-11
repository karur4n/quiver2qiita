require 'quiver2qiita/api_client'
require 'quiver2qiita/config/history'
require 'quiver2qiita/item_builder'
require 'quiver2qiita/notebook'
require 'quiver2qiita/user_config'

module Quiver2qiita
  module Commands
    class Sync
      def initialize
        @api_client = ApiClient.new
        @api_client.set_access_token
      end

      def run
        sync_notes
      end

      private

      def sync_notes
        config = UserConfig.new
        history = Config::History.new

        config.notebook_paths.each do |notebooks_path|
          # ワイルドカード * パスのために entries
          Dir.glob(notebooks_path).entries.each do |notebook_path|
            Notebook.new(notebook_path).notes.each do |note|
              next unless note.updated?
              next if note.has_unsupported_cell?

              item = ItemBuilder.build(note)

              if note.posted?
                response = @api_client.patch("/api/v2/items/#{note.qiita_id}", item)
              else
                response = @api_client.post('/api/v2/items', item)
              end

              status = response.status

              if status == 200 || status == 201
                history.add(note.uuid, {
                  updated_at: note.updated_at,
                  qiita_id: response.body['id']
                })
                print '✅ '
                puts " #{response.body['title']} - #{response.body['url']}"
              else
                p response.body
                print '❌ '
                puts " #{note.title}"
              end
            end
          end
        end

        history.save
      end
    end
  end
end
