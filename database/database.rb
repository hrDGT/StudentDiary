# frozen_string_literal: true

require 'pg'

module Database
  # Database singleton class
  class Database
    @instance = new

    private_class_method :new

    class << self
      attr_reader :instance
    end

    def execute_query(query:, values: [])
      @connection.exec_params(query, values)
    end

    def setup
      ensure_database_exists
      connect_to_database
      create_tables
    end

    private

    def ensure_database_exists
      conn = PG.connect(
        host: ENV.fetch('PG_HOST'),
        user: ENV.fetch('PG_USER'),
        password: ENV.fetch('PG_PASSWORD')
      )

      result = conn.exec("SELECT 1 FROM pg_database WHERE datname='#{ENV.fetch('PG_DBNAME')}'")
      conn.exec("CREATE DATABASE #{ENV.fetch('PG_DBNAME')}") if result.ntuples.zero?
    end

    def connect_to_database
      @connection = PG.connect(
        host: ENV.fetch('PG_HOST'),
        dbname: ENV.fetch('PG_DBNAME'),
        user: ENV.fetch('PG_USER'),
        password: ENV.fetch('PG_PASSWORD')
      )
    end

    def create_tables
      @connection.exec(File.read(File.join(File.dirname(__FILE__), 'create_tables.sql')))
    end
  end
end
