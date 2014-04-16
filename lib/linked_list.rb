class LinkedList
  attr_reader :size

  def initialize(*args)
    @size = 0
    args.each { |item| add_item(item)  }
  end

  def add_item(payload)
    lli = LinkedListItem.new(payload)
    if @first_item.nil?
      @first_item = lli
    else
      item = @first_item
      until item.last?
        item = item.next_list_item
      end
      item.next_list_item = lli
    end
    @size += 1
  end

  def get(i)
    raise IndexError if i < 0 or i >= size
    item = @first_item
    i.times do
      item = item.next_list_item
    end
    item.payload
  end

  def last
    if size == 0
      nil
    else
      get(size - 1)
    end
  end

  def to_s
    result = "|"
    item = @first_item
    until item.nil?
      result << " :" + item.payload.to_s if item.payload.class == Symbol
      result << " " + item.payload.to_s if item.payload.class == String
      result << " " + item.payload.to_s if item.payload.class == Fixnum
      result << "," unless item.last?
      item = item.next_list_item
    end
    result + " |"
  end

  alias [] get #<-- insteat of def [](index)
               #                 get(index)
               #               end

  def []=(i, new_arg)
    current_item = @first_item
    if i == 0
      current_item.payload = new_arg
    else
      i.times do
        current_item = current_item.next_list_item
      end
      current_item.payload = new_arg
    end
  end

  def remove(index)
    @size -= 1
    if index == 0
      @first_item = @first_item.next_list_item
    else
      previous_item = get_item( index - 1 )
      next_list_item = previous_item.next_list_item.next_list_item
      previous_item.next_list_item = next_list_item
    end
  end

  def indexOf(payload)
    item = @first_item
    position = 0
    until item.nil?
      return position if item.payload == payload
      position += 1
      item = item.next_list_item
    end
    nil
  end

  def sorted?
    item = @first_item
    until item.nil  or item.last?
      return false if item > item.next_list_item
      item = item.next_list_item
    end
    true
  end

  private

  def get_item(i)
    raise IndexError if i < 0 or i >= size
    item = @first_item
    i.times do
      item = item.next_list_item
    end
    item
  end

end


=begin
require 'linked_list_item'

class LinkedList
  attr_accessor :first_item
  attr_accessor :last_item

  def initialize(*args)
    self.last_item = nil
    args.each do |arg|
      self.add_item(arg)
    end
  end

  def add_item(payload)
    new_item = LinkedListItem.new(payload)
    if (self.first_item == nil)
      self.first_item = new_item
    else
      current = self.first_item
      while current.next_list_item != nil
        current = current.next_list_item
      end
      current.next_list_item = new_item
    end
    self.last_item = new_item
  end

  def get(num)
    current = self.first_item
    raise IndexError if num < 0
    (0..num).each do |x|
      if (current == nil)
        raise IndexError
      elsif (x == num)
        return current.payload
      else
        current = current.next_list_item
      end
    end
  end

  def size
    size = 0
    current = self.first_item
    while current != nil
      size += 1
      current = current.next_list_item
    end
    size
  end

  def last
    if (self.last_item == nil)
      nil
    else
      self.last_item.payload
    end
  end

  def to_s
    x = "| "
    current = self.first_item
    while current != nil
      x = x + current.payload.to_s
      current = current.next_list_item
      if (current != nil)
        x = x + ","
      end
      x = x + " "
    end
    x = x + "|"
    x
  end

  def [](num)
    self.get(num)
  end

  def []=(num, newvalue)
    current = self.first_item
    (0..num).each do |x|
      if (x == num)
        current.payload = newvalue
        break
      elsif (current == nil)
        raise IndexError
      else
        current = current.next_list_item
      end
    end
  end

  #def remove(num)
  #  current = self.first_item
  #  if (num < 0)
  #    raise IndexError
  #  end
  #  (0..num).each do |x|
  #    if (x == num)
  #      current.payload = 
  #end

end
=end
