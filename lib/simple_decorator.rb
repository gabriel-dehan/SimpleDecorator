# SimpleDecorator allows you to give true decorator behavior to your classes.
#
# Author:  Gabriel Dehan (gabriel-dehan)
#
# License: WTFPL (http://sam.zoy.org/wtfpl/COPYING)
class SimpleDecorator < BasicObject
  undef_method :==

  def initialize(component)
    @component = component
  end

  def decorated
    @component
  end
  alias :source :decorated

  def method_missing(n, *a, &b); @component.send(n, *a, &b) end
  def send(s, *a); __send__(s, *a) end
end
