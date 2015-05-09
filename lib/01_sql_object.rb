require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    results = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{table_name};
    SQL

    results.first.map { |col| col.to_sym }
  end

  def self.finalize!
    columns.each do |col|
      define_method("#{col}=") do |value|
        attributes[col] = value
      end

      define_method("#{col}") do
        attributes[col]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM
      #{table_name};
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map do |instance|
      thing = self.new(instance)
    end
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id: id)
    SELECT
      *
    FROM
      #{table_name}
    WHERE
      #{table_name}.id = :id;
    SQL
    self.new(results.first) unless results.empty?
  end

  def initialize(params = {})
    cols = self.class.columns
    params.each do |key, value|
      att_name = key.to_sym
      raise "unknown attribute #{key}" unless cols.include?(att_name)
      self.send("#{att_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    attributes.values
  end

  def insert
    num_cols = attribute_values.length
    col_names = attributes.keys.join(", ")
    question_marks = (["?"] * num_cols).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks});
    SQL
    value = DBConnection.last_insert_row_id
    self.send("id=", value)
  end

  def update
    sets = self.class.columns.map { |col| "#{col} = ?"}.join(", ")
    input = attribute_values << id
    # [2, "Matthew", "von Rubens", 1]
    DBConnection.execute(<<-SQL, *input)
    UPDATE
      #{self.class.table_name}
    SET
      #{sets}
    WHERE
      id = ? ;
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
