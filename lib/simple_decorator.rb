require 'delegate'

# Author::  Gabriel Dehan (gabriel-dehan)
# License:: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
#
# Allows you to give true decorator behavior to your classes.
class SimpleDecorator < Delegator
  # We must undefine those methods, for they will be sent to the underlying
  # object
  undef_method :==
  undef_method :class
  undef_method :instance_of?

  # Stores the decorated object
  def initialize(component)
    super
    @component = component
  end

  # Returns the component
  def decorated
    @component
  end
  alias :source :decorated

  def __setobj__(o); @component = o   end
  def __getobj__;    @component       end
  def send(s, *a);   __send__(s, *a)  end
end
