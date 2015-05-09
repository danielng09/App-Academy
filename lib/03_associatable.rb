require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    class_name.downcase.concat("s")
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = "#{name}_id".to_sym
    @primary_key = :id
    @class_name = name.to_s.camelcase
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.downcase}_id".to_sym
    @primary_key = options[:primary_key] || :id
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {}) #take in association name
    hash = BelongsToOptions.new(name, options)
    define_method(name) do
      fk = self.send(hash.foreign_key)
      cn = hash.model_class
      output = cn.where(id: fk).first
    end
  end

  def has_many(name, options = {})
    define_method(name) do
      hash = HasManyOptions.new(name, self.class.to_s, options)
      pk = self.send(hash.primary_key)
      fkn = hash.foreign_key
      table = hash.model_class
      output = table.where(fkn => pk)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
