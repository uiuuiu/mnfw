class Admin::IndexService
  prepend SimpleCommand

  def initialize(klass, records, page, limit, opts={})
    @klass = klass
    @records = records
    @page = page
    @limit = limit
    @opts = opts
  end

  def call
    raise "#{klass} is not a model class" unless klass.is_a?(Class)
    raise "#{klass} is not a model" unless klass.superclass == ApplicationRecord
    opts[:columns] = klass.column_names if !opts[:columns] || opts[:columns].empty?
    [records.page(page).per(limit), opts]
  end

  private

  attr_accessor :klass, :records, :page, :limit, :opts
end