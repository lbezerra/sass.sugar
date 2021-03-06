require 'sass/script'
require 'sass/script/css_lexer'

module Sass
  module Script
    class CssParser < Parser
      private

      # @private
      def lexer_class; CssLexer; end

      # We need a production that only does /,
      # since * and % aren't allowed in plain CSS
      production :div, :unary_plus, :div

      def string
        return number unless tok = try_tok(:string)
        return tok.value unless @lexer.peek && @lexer.peek.type == :begin_interpolation
      end

      # Short-circuit all the SassScript-only productions
      alias_method :interpolation, :concat
      alias_method :or_expr, :div
      alias_method :unary_div, :funcall
      alias_method :paren, :string
    end
  end
end
