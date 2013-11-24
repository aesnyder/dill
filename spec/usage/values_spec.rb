require 'spec_helper'

describe 'Widget values' do
  describe 'Widgets as strings' do
    GivenHTML <<-HTML
      <span id="my-widget">Hello, world!</span>
    HTML

    GivenWidget do
      Str = Dill::String('#my-widget')
    end

    Then { value(:str) == 'Hello, world!' }
  end

  describe 'Widgets as integers' do
    context 'Widget content can be cast to an integer' do
      GivenHTML <<-HTML
        <span id="my-widget">1</span>
      HTML

      GivenWidget do
        Int = Dill::Integer('#my-widget')
      end

      Then { value(:int) == 1 }
    end

    context 'Widget content cannot be cast to an integer' do
      GivenHTML <<-HTML
        <span id="my-widget">String</span>
      HTML

      GivenWidget do
        Int = Dill::Integer('#my-widget')
      end

      When(:result) { value(:int) }

      Then { result == Failure(ArgumentError, /invalid value for Integer()/) }
    end
  end


  describe 'Widgets as decimals' do
    context 'Widget content can be cast to a float' do
      GivenHTML <<-HTML
        <span id="my-widget">1.5</span>
      HTML

      GivenWidget do
        Dec = Dill::Decimal('#my-widget')
      end

      Then { value(:dec) == 1.5 }
      And { value(:dec).is_a?(BigDecimal) } # ensure precision
    end

    context 'Widget content cannot be cast to a float' do
      GivenHTML <<-HTML
        <span id="my-widget">String</span>
      HTML

      GivenWidget do
        Dec = Dill::Decimal('#my-widget')
      end

      When(:result) { value(:dec) }

      Then { result == Failure(ArgumentError, /invalid value for Float()/) }
    end
  end
end