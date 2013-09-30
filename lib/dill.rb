require 'chronic'
require 'nokogiri'
require 'capybara'

require 'dill/conversions'
require 'dill/instance_conversions'
require 'dill/checkpoint'
require 'dill/dynamic_value'
require 'dill/widgets/widget_class'
require 'dill/widgets/widget_checkpoint'
require 'dill/widgets/widget_container'
require 'dill/widgets/node_text'
require 'dill/widgets/widget_name'
require 'dill/widgets/widget'
require 'dill/widgets/list_item'
require 'dill/widgets/list'
require 'dill/widgets/base_table'
require 'dill/widgets/auto_table'
require 'dill/widgets/table'
require 'dill/widgets/field_group'
require 'dill/widgets/form'
require 'dill/widgets/document'
require 'dill/text_table'
require 'dill/text_table/mapping'
require 'dill/text_table/void_mapping'
require 'dill/text_table/transformations'
require 'dill/text_table/cell_text'
require 'dill/dsl'

module Dill
  # An exception that signals that something is missing.
  class Missing < StandardError; end
end
