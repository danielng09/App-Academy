require 'SQLite3'
require 'Singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*arg, &blk)
    self.instance.execute(*arg, &blk)
  end

  def self.get_first_row
    self.instance.get_first_row(*arg, &blk)
  end
end



# module RubyQueries
#   def self.all(table)
#     results = QuestionsDatabase.execute(<<-SQL, table: table)
#       SELECT
#         *
#       FROM
#         table
#     SQL
#     results.map { |result| self.new(result)}
#   end
#
#   def self.find_by_id(table, table_pk)
#     results = QuestionsDatabase.instance.get_first_row(<<-SQL, table: table, table_pk: id)
#       SELECT
#         *
#       FROM
#         :table
#       WHERE
#         questions.id = :table_pk;
#     SQL
#     self.new(results)
#   end
# end
