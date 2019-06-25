# frozen_string_literal: true

module PaginationMeta
  extend ActiveSupport::Concern

  def paginate(scope)
    scope
      .page(params[:page])
      .per per_page
  end

  def per_page
    params[:per] == 0 ? nil : params[:per]
  end

  def pagination_meta(scope)
    { total: scope.total_count, total_pages: scope.total_pages, page: scope.current_page, per: scope.current_per_page }
  end
end
