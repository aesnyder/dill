Given(/^the following HTML:$/) do |string|
  define_page_body string
end

Given(/^the following widget definition:$/) do |string|
  @widget_class = define_constant(string)
end
