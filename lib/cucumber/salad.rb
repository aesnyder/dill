require 'chronic'

require 'cucumber/salad/conversions'
require 'cucumber/salad/instance_conversions'
require 'cucumber/salad/node_text'
require 'cucumber/salad/widget_name'
require 'cucumber/salad/widgets'
require 'cucumber/salad/table'
require 'cucumber/salad/table/mapping'
require 'cucumber/salad/table/void_mapping'
require 'cucumber/salad/table/transformations'
require 'cucumber/salad/table/cell_text'
require 'cucumber/salad/widgets/document'
require 'cucumber/salad/dsl'

class UnknownWidgetError < StandardError; end

World(Cucumber::Salad::DSL)
