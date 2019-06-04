# frozen_string_literal: true

module PaginationMeta
  extend ActiveSupport::Concern

  def paginate(scope)
    scope
      .page(params[:page])
      .per per_page
  end

  def per_page
    # из-за ошибки на фронте per может быть =0
    # https://app.bugsnag.com/alfa-genesis/admin-dot-kassa-dot-cc/errors/5b62ef0480a1e500177852e4?filters[event.since][0][type]=eq&filters[event.since][0][value]=30d&filters[error.status][0][type]=eq&filters[error.status][0][value]=open&filters[app.release_stage][0][value]=production&filters[app.release_stage][0][type]=eq
    params[:per] == 0 ? nil : params[:per]
  end

  def pagination_meta(scope)
    { total: scope.total_count, total_pages: scope.total_pages, page: scope.current_page, per: scope.current_per_page }
  end
end
