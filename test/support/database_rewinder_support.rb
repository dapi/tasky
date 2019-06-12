# frozen_string_literal: true

module DatabaseRewinderSupport
  def before_setup
    super
    DatabaseRewinder.start
  end

  def after_teardown
    DatabaseRewinder.clean
    super
  end
end
