class Admin::EditService
  prepend SimpleCommand

  TIMESTAMPS = ['created_at', 'updated_at']

  def initialize(record, opts={})
    @record = record
    @opts = opts
    @opts[:timestamps] ||= false
    opts[:editable_columns] ||= []
  end

  def call
    raise "#{record.class.superclass} is not a model" unless record.class.superclass == ApplicationRecord
    column_names = record.class.column_names
    column_names = column_names - TIMESTAMPS unless opts[:timestamps]
    opts[:columns] = column_names if !opts[:columns] || opts[:columns].empty?
    opts[:columns] = opts[:columns].reject {|col| col == 'id' || col == :id}
    opts[:edit_columns] = {}
    opts[:columns].each do |col|
      opts[:edit_columns][col.to_sym] = opts[:editable_columns].include?(col.to_sym)
    end
    [record, opts]
  end

  private

  attr_accessor :record, :opts
end