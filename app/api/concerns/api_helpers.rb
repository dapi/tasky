# frozen_string_literal: true

module ApiHelpers
  extend ActiveSupport::Concern
  included do
    helpers do
      include PaginationMeta

      def strict_hash(hash)
        # TODO: Удалять чувствительную информацию, пароли и тп
        hash.reject { |_k, v| v.blank? }
      end

      def parsed_metadata
        Oj.load params[:metadata].to_s
      rescue Oj::ParseError => e
        Rails.logger.error "#{e} (#{params[:metadata]})"
      end

      def by_metadata(scope)
        metadata = params[:metadata]
        return scope unless metadata.is_a? Hash

        scope.by_metadata metadata.dig(:operator), JSON.parse(metadata.dig(:query))
      end

      def jsonapi_include
        params[:include].to_s.split(',').map(&:squish).compact.uniq
      end
    end
  end
end
