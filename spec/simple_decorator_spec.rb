require 'spec_helper'

describe SimpleDecorator do
  before do
    # User mock object
    @user_mock = double('user')
    @user_mock.stub('first_name') { 'Foo' }
    @user_mock.stub('last_name') { 'Bar' }
    @user_mock.stub('count') { 1 }

    # Interface mock object
    @interface_mock = double('simple_decorator')
    @interface_mock.stub('first_name') { 'Geronimo' }
    @interface_mock.stub('count') { @component.count + 1 }

    # An other interface mock object
    @other_interface_mock = double('simple_decorator')
    @other_interface_mock.stub('count') { @component.count + 1 }
  end
  describe "is a true decorator" do
    before do
      @user      = @user_mock.new
      @interface = @interface_mock.new(@user)
    end
    it 'should take an object as an argument for instanciation' do
      @interface_mock.new(@user)

      @interface.should be_an_instance_of(@user)
    end

    it 'should be fully transparent' do
      @interface.should_receive(:new).with(@user).and_return(@user)
      @interface_mock.new(@user)
    end

    it 'should receive any known method an not pass them to the component' do
      @interface.first_name.should == 'Geronimo'
    end

    it 'should delegate unknown methods to the underlying component' do
      @interface_mock.should_receive(:last_name)
      @interface.should_receive(:last_name).and_return('Bar')
    end

    it 'should be able to decorate a decorator' do
      decorator = @other_interface_mock.new(@interface)

      @user.count.should      == 1
      @interface.count.should == 2
      decorator.count.should  == 3
    end
  end # is a true decorator

end