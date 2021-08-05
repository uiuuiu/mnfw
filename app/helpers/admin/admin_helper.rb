module Admin::AdminHelper
  DEFAULT_OPTIONS = {required: true}

  def element_tag(form_builder, record, attr, editable)
    return record[attr] unless editable

    klass = record.class

    case klass.type_for_attribute(attr)
    when ActiveModel::Type::Integer
      return form_builder.number_field(attr, DEFAULT_OPTIONS)
    when ActiveModel::Type::String
      return form_builder.text_field(attr, DEFAULT_OPTIONS)
    when ActiveRecord::Enum::EnumType
      return form_builder.select(attr, klass.defined_enum[attr], DEFAULT_OPTIONS)
    end
  end
end