# frozen_string_literal: true

require 'pg'

module Database
  # Database class
  class Database
    def self.connection
      @connection ||= PG.connect(
        host: ENV.fetch('PG_HOST'),
        dbname: ENV.fetch('PG_DBNAME'),
        user: ENV.fetch('PG_USER'),
        password: ENV.fetch('PG_PASSWORD')
      )
    end

    def self.execute_query(query)
      connection.exec(query)
    end

    def self.setup
      conn = PG.connect(
        host: ENV.fetch('PG_HOST'),
        user: ENV.fetch('PG_USER'),
        password: ENV.fetch('PG_PASSWORD')
      )

      result = conn.exec("SELECT 1 FROM pg_database WHERE datname='#{ENV.fetch('PG_DBNAME')}'")
      conn.exec("CREATE DATABASE #{ENV.fetch('PG_DBNAME')}") if result.ntuples.zero?

      sql = File.read(File.join(File.dirname(__FILE__), 'create_tables.sql'))
      conn.exec(sql)
    end
  end
end
