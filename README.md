SimpleDecorator
===============

SimpleDecorator allows you to quickly implement Decorators in your application.

# A true decorator
SimpleDecorator decorators are true decorators :
* They delegate unknown methods to the underlying objects
  ```ruby
  class User
    def foo
      'bar'
    end
  end

  class Decorator < SimpleDecorator

  end

  user_decorator = Decorator.new(User.new)
  user_decorator.foo
  # => 'bar'
  ```

* They can be stacked infinitely
  ```ruby
    class User
      def initialize; @count = 1 end

      def count
        @count
      end
    end

    class CountDecorator < SimpleDecorator
     def count
       @component.count + 1
     end
    end

    class TripleCountDecorator < SimpleDecorator
      def count
        @component.count * 3
      end
    end

    user = User.new
    user.count
    # => 1

    CountDecorator.new(CountDecorator.new(user)).count
    # => 3

    TripleCountDecorator.new(CountDecorator.new(user)).count
    # => 6
  ```

* They are fully transparent
  ```ruby
    class User; end
    class Decorator < SimpleDecorator; end
    class OtherDecorator < SimpleDecorator; end

    user = User.new
    decorator = Decorator.new(OtherDecorator.new(user))
    decorator.class
    # => User
    decorator.instance_of? User
    # => true
    decorator == user
    # => true
  ```

# Usage
To create a decorator, simply inherit from SimpleDecorator.

```ruby
  class Decorator < SimpleDecorator
  end
```

Then, you just need to wrap your object inside your Decorator class
```ruby
  class Foobar; end
  # Decorator#new takes the instance you want to decorate as an argument
  Decorator.new(Foobar.new)
```

It will give you access to the following instance methods :
 `source`, `decorated` which will return decorated object.

Inside your Decorator class, you can access the decorated object through the instance variable `@component`
```ruby
  class Foobar
    def foo
      'bar'
    end
  end

  class Decorator < SimpleDecorator
    def foo
      'foo' + @component.foo
    end
  end

  Decorator.new(Foobar.new).foo
  # => 'foobar'
```

# Misc
'Licensed' under [WTFPL](http://sam.zoy.org/wtfpl/COPYING)

