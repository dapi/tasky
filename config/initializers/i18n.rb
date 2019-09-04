# frozen_string_literal: true

module I18n
  # Implemented to support method call on translation keys
  INTERPOLATION_WITH_METHOD_PATTERN = Regexp.union(
    /%%/,
    /%\{(\w+)\}/,                               # matches placeholders like "%{foo}"
    /%<(\w+)>(.*?\d*\.?\d*[bBdiouxXeEfgGcps])/, # matches placeholders like "%<foo>.d"
    /%\{(\w+)\.(\w+)\}/ # matches placeholders like "%{foo.upcase}"
  )

  class << self
    def interpolate_hash(string, values)
      string.gsub(INTERPOLATION_WITH_METHOD_PATTERN) do |match|
        if match == '%%'
          '%'
        else
          key = (Regexp.last_match[1] || Regexp.last_match[2] || Regexp.last_match[4]).to_sym
          value = values.key?(key) ? values[key] : "%{#{key}}" #  raise(MissingInterpolationArgument.new(key, values, string))
          value = value.call(values) if value.respond_to?(:call)
          if Regexp.last_match[3]
            "%#{Regexp.last_match[3]}" % value
          elsif value.is_a? Hash
            (Regexp.last_match[5] ? value[Regexp.last_match[5].to_sym] : value)
          else
            (Regexp.last_match[5] ? value.send(Regexp.last_match[5]) : value)
          end
        end
      end
    end
  end
end
