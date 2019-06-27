# frozen_string_literal: true

class Grape::Validations::ParamsScope
  META_OPERATORS = MetadataSupport::AVAILABLE_OPERATORS.map { |op| CGI.escapeHTML op }

  def optional_metadata_query
    optional :metadata, type: Hash, desc: 'Search by metadata' do
      optional :operator,
               type: String,
               desc: %(Operator from Postgresql JSONB specification
               https://www.postgresql.org/docs/10/functions-json.html#FUNCTIONS-JSONB-OP-TABLE
               Available values: #{META_OPERATORS})

      optional :query, type: String, desc: 'JSON to serach.<br/>Example: "{ "client_id": 123 }"'

      all_or_none_of :operator, :query
    end
  end

  def optional_metadata
    optional :metadata, type: String, desc: 'metadata in JSON', default: '{}'
  end

  def optional_include(serializer)
    optional :include,
             type: String,
             desc: 'Comma separated list of entity relationships to present<br/>' \
             "Available: [#{serializer.relationships_to_serialize.keys.join(', ')}]"
  end
end
