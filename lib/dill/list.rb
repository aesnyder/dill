module Dill
  # Use a List when you want to treat repeating elements as a unit.
  #
  # === Example
  #
  # Consider the following HTML:
  #
  #   <ul id="colors">
  #     <li>Red <span class="pt">Vermelho</span></li>
  #     <li>Green <span class="pt">Verde</span></li>
  #     <li>Blue <span class="pt">Azul</span></li>
  #   </ul>
  #
  # You can then define the following widget:
  #
  #   class Colors < Dill::List
  #     root '#colors'
  #   end
  #
  # Now you'll be able to iterate over each item:
  #
  #   # prints:
  #   # Red Vermelho
  #   # Green Verde
  #   # Blue Azul
  #   widget(:colors).each do |e|
  #     puts e
  #   end
  #
  # === Narrowing items
  #
  # You can define the root selector for your list items using the ::item macro:
  #
  #   class PortugueseColors < Dill::List
  #     root '#colors
  #     item '.pt'
  #   end
  #
  # If you iterate over this list you get the following:
  #
  #   # prints:
  #   # Vermelho
  #   # Verde
  #   # Azul
  #   widget(:portuguese_colors).each do |e|
  #     puts e
  #   end
  #
  # You can make a list out of any repeating elements, as long as you can define
  # parent and child selectors.
  #
  #   <div id="not-a-list-colors">
  #     <div class=".child">Red</div>
  #     <div class=".child">Green</div>
  #     <div class=".child">Blue</div>
  #   </div>
  #
  # You can define the following widget:
  #
  #   class NotAListColors < Dill::List
  #     root '#not-a-list-colors'
  #     item '.child'
  #   end
  class List < Widget
    DEFAULT_TYPE = Widget

    include Enumerable

    def_delegators :items, :size, :include?, :each, :empty?, :first, :last

    def self.item(selector, type = DEFAULT_TYPE, &item_for)
      define_method :item_selector do
        @item_selector ||= selector
      end

      if block_given?
        define_method :item_for, &item_for
      else
        define_method :item_factory do
          type
        end
      end
    end

    def to_table
      items.map { |e| Array(e) }
    end

    protected

    attr_writer :item_selector

    def item_factory
      DEFAULT_TYPE
    end

    def item_for(node)
      item_factory.new(root: node)
    end

    def item_selector
      'li'
    end

    def items
      root.all(item_selector).map { |node| item_for(node) }
    end
  end
end
