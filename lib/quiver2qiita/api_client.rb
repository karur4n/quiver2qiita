# frozen_string_literal: true
require 'faraday'
require 'faraday_middleware'
require 'quiver2qiita/user_config'

module Quiver2qiita
  class ApiClient
    BASE_URL = 'https://qiita.com/api/v2'

    def initialize
      @connection = nil
      @user_config = UserConfig.new

      build_connection
    end

    def patch(path, data)
      @connection.patch(path, data)
    end

    def post(path, data)
      @connection.post(path, data)
    end

    def set_access_token
      token = @user_config.access_token
      @connection.authorization(:Bearer, token)
    end

    private

    def build_connection(**params)
      @connection = Faraday.new(BASE_URL, params) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
