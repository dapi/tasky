# frozen_string_literal: true

class Grape::Validations::ParamsScope
  META_OPERATORS = MetadataSupport::AVAILABLE_OPERATORS.map { |op| CGI.escapeHTML op }

  def optional_metadata_query
    optional :metadata, type: Hash, desc: 'Поиск по metadata' do
      optional :operator,
               type: String,
               desc: %(Оператор согласно спецификации Postgresql JSONB
               https://www.postgresql.org/docs/10/functions-json.html#FUNCTIONS-JSONB-OP-TABLE
               А именно: #{META_OPERATORS})

      optional :query, type: String, desc: 'JSON для поиска.<br/>Например "{ "client_id": 123 }"'

      all_or_none_of :operator, :query
    end
  end

  def optional_metadata
    optional :metadata, type: String, desc: 'metadata в JSON формате', default: '{}'
  end

  def optional_include(serializer)
    optional :include,
             type: String,
             desc: 'Список relationships через запятую для презентации<br/>' \
             "Доступны: [#{serializer.relationships_to_serialize.keys.join(', ')}]"
  end
end
