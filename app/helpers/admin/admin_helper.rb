module Admin::AdminHelper
  DEFAULT_OPTIONS = {required: true}

  def element_tag(form_builder, record, attr, opts={}, tag_opts={})
    return content_tag(:div, record[attr]) unless opts[:editable]
    data = opts[:data][attr]
    tag_opts.merge(DEFAULT_OPTIONS)
    data ?
      build_tag_by_data_type(form_builder, attr, data, opts, tag_opts) :
      build_tag_by_default_type(form_builder, record, attr, opts, tag_opts)
  end

  def build_tag_by_data_type form_builder, attr, data, opts, tag_opts
    case data
    when Integer, BigDecimal
      return form_builder.number_field(attr, tag_opts.merge(value: data))
    when String
      return form_builder.text_field(attr, tag_opts.merge(value: data))
    when Array
      return form_builder.select(attr, data, tag_opts)
    end
  end

  def build_tag_by_default_type form_builder, record, attr, opts, tag_opts
    klass = record.class
    case klass.type_for_attribute(attr)
    when ActiveModel::Type::Integer, ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Decimal
      return form_builder.number_field(attr, tag_opts)
    when ActiveModel::Type::String
      return form_builder.text_field(attr, tag_opts)
    when ActiveRecord::Enum::EnumType
      return form_builder.select(attr, klass.defined_enums[attr.to_s], tag_opts)
    end
  end
end