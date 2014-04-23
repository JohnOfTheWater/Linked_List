class LinkedListItem
  include Comparable  #<-- The Comparable mixin is used by classes whose objects may be ordered.
                      #    The class must define the <=> operator, which compares the receiver against another object, returning -1, 0, or +1 depending on whether the receiver is less than, equal to, or greater than the other object. If the other object is not comparable then the <=> operator should return nil. Comparable uses <=> to implement the conventional comparison operators (<, <=, ==, >=, and >) and the method between?.
  attr_accessor :payload
  attr_reader :next_list_item

  def initialize(payload)
    @payload = payload
    @next_list_item = nil #<-- nil is an actual object. You can call methods or
                          #    add methods to nil, just like any other object.
  end

  #def next_list_item   <-- I wrote the attr_reader instead
  #  @next_list_item
  #end

  def next_list_item= (payload)
    raise ArgumentError if self === payload
    @next_list_item = payload
  end

  def === (other)
    self.object_id === other.object_id
  end

  def last?
    @next_list_item == nil
  end

  def <=> (other)  #<-- <=> Combined comparison operator. Returns 0 if first operand equals second, 1 if first operand is greater than the second and -1 if first operand is less than the second.
    payload1 = self.payload
    payload2 = other.payload

    precedence = [Fixnum, String, Symbol]
    index1 = precedence.index(payload1.class)
    index2 = precedence.index(payload2.class)
    class_equality = (index1 <=> index2)

    if class_equality == 0
      payload1 <=> payload2
    else
      class_equality
    end
  end

end
