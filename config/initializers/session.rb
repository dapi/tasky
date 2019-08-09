# frozen_string_literal: true

Tasky::Application.config.session_store :cookie_store,
                                        key: '_tasky',
                                        domain: Settings.default_url_options.host,
                                        tld_length: ActionDispatch::Http::URL.tld_length,
                                        httponly: false
