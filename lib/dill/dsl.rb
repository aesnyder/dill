module Dill
  module DSL
    attr_writer :widget_lookup_scope

    # @return [Document] the current document with the class of the
    #   current object set as the widget lookup scope.
    def document
      Document.new(widget_lookup_scope)
    end

    # @return [Boolean] Whether one or more widgets exist in the current
    #   document.
    def has_widget?(name, *args)
      document.has_widget?(name, *args)
    end

    def value(name, *args)
      widget(name, *args).value
    end

    # Returns a widget instance for the given name.
    #
    # @param name [String, Symbol]
    def widget(name, *args)
      document.widget(name, *args)
    end

    def widget_lookup_scope
      @widget_lookup_scope ||= default_widget_lookup_scope
    end

    # re-run one or more assertions until either they all pass,
    # or Dill times out, which will result in a test failure.
    def eventually(wait_time = Capybara.default_wait_time, &block)
      Checkpoint.wait_for wait_time, &block
    end

    private

    def default_widget_lookup_scope
      Module === self ? self : self.class
    end
  end
end
