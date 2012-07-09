require 'spec_helper'

describe SimpleDecorator do
  before do
    # User mock object
    @user = mock('user')
    @user.stub('first_name') { 'Foo' }
    @user.stub('last_name') { 'Bar' }
    @user.stub('count') { 1 }

    # Interface
    @decorator = SimpleDecorator.new(@user)
    def @decorator.first_name; 'Geronimo' end
    def @decorator.count; @component.count + 1 end

    # An other decorator
    @other_decorator = SimpleDecorator.new(@decorator)
    def @other_decorator.count; @component.count + 2 end
  end
  describe "is a true decorator" do
    describe 'Object behavior' do
      it 'should take an object as an argument for instanciation' do
        SimpleDecorator.new(@user).should_not raise_error(ArgumentError)
      end

      describe 'should be fully transparent' do
        it { @decorator.should be_an_instance_of(@user.class) }
        it { @decorator.should == @user }
      end
    end # Object behavior

    describe 'Delegation behavior' do
      it 'should receive any known method an not pass them to the component' do
        @decorator.first_name.should == 'Geronimo'
        @decorator.first_name.should_not == 'Foo'
      end

      it 'should delegate unknown methods to the underlying component' do
        @decorator.last_name.should == 'Bar'
      end

      it 'should be able to decorate a decorator' do
        @user.count.should      == 1
        @decorator.count.should == 2
        @other_decorator.count.should  == 4
      end
    end # Delegation behavior
  end # is a true decorator
end