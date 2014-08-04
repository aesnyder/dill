Feature: Finding

  Use [#widget](https://github.com/mojotech/dill/blob/master/lib/dill/widgets/dsl.rb) to find a single widget in the current document.

  Scenario: finding a widget with a simple selector
    Given the following HTML:
      """
      <div id="the-widget"></div>
      """
    And the following widget definition:
      """
      class MyWidget < Dill::Widget
        root "#the-widget"
      end
      """
    Then we can get an instance of the widget with:
      """
      widget(:my_widget)
      """
    And we can also get an instance of the widget with:
      """
      widget("my_widget")
      """

  Scenario: finding a widget with a composite selector
    Given the following HTML:
      """
      <ul>
        <li>One</li>
        <li>Two</li>
      </ul>
      """
    And the following widget definition:
      """
      class OneItem < Dill::Widget
        root "li", :text => "One"
      end
      """
    Then we can get an instance of the widget with:
      """
      widget(:one_item)
      """

  Scenario: finding a widget with a dynamic selector
    Given the following HTML:
      """
      <ul>
        <li>One</li>
        <li>Two</li>
      </ul>
      """
    And the following widget definition:
      """
      class ListItem < Dill::Widget
        root { |text| ["li", :text => text] }
      end
      """
    Then we can get an instance of the first "li" with:
      """
      widget(:list_item, "One")
      """

  @javascript
  Scenario: finding a widget that only appears after a time
    Given the following HTML:
      """
      <div>Their Widget</div>
      """
    And the following widget definition:
      """
      class WaitingWidget < Dill::Widget
        root 'div', :text => 'My Widget'
      end
      """
    When we try to get the widget with:
      """
      widget(:waiting_widget)
      """
    And the widget's content changes to "My Widget" before the timeout expires
    Then we will get an instance of the widget

  Scenario: can't find a widget
    Given the following HTML:
      """
      <div>Widget</div>
      """
    And the following widget definition:
      """
      class MissingWidget < Dill::Widget
        root 'li'
      end
      """
    When we try to find the widget with:
      """
      widget(:missing_widget)
      """
    Then we will get the error Dill::MissingWidget

  Scenario: ambiguous selector
    Given the following HTML:
      """
      <div>Widget</div>
      <div>Another Widget</div>
      """
    And the following widget definition:
      """
      class AmbiguousWidget < Dill::Widget
        root 'div'
      end
      """
    When we try to find the widget with:
      """
      widget(:ambiguous_widget)
      """
    Then we will get the error Dill::AmbiguousWidget
