# frozen_string_literal: true

ActionDispatch::Http::URL.tld_length = Settings.default_url_options.host.split('.').count - 1

Tasky::Application.config.session_store :cookie_store,
                                        key: '_tasky',
                                        domain: Settings.default_url_options.host,
                                        tld_length: ActionDispatch::Http::URL.tld_length,
                                        httponly: false
