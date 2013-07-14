module Cucumber
  module Salad
    module WidgetContainer
      def has_widget?(name)
        widget_class(name).has_instance?(root)
      end

      def widget(name)
        widget_class(name).in_node(root)
      end

      private

      attr_writer :widget_lookup_scope

      def widget_class(name)
        WidgetName.new(name).to_class(widget_lookup_scope)
      end

      def widget_lookup_scope
        @widget_lookup_scope || self.class
      end
    end
  end
end
