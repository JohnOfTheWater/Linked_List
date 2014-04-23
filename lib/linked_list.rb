class LinkedList
  include Comparable
  attr_reader :size
  attr_writer :first_item

  def initialize(*args)
    @size = 0
    if args
      args.each {|item| add_item(item)}
    else
      args = nil
    end
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
    raise IndexError if (i < 0) or (i  >= size)
    item = @first_item
    i.times do
      item = item.next_list_item
    end
    item.payload
  end

  def size
    @size
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
      result << " " + item.payload.to_s
      result << "," unless item.last?
      item = item.next_list_item
    end
    result + " |"
  end

  alias [] get #<-- alias means same as

  def []=(index, new_payload)
    item = @first_item
    index.times do
      item = item.next_list_item
    end
    item.payload = new_payload
  end

  def remove(index)
    item = @first_item

    raise IndexError if (index < 0) or (index >= @size)

    if index != 0
      (index-1).times {item = item.next_list_item}
      item.next_list_item = item.next_list_item.next_list_item
    else
      @first_item = @first_item.next_list_item
    end

    @size = @size - 1
  end

  def indexOf(string)
    if @size == 0
      return nil
    end

    index = 0
    item = @first_item

    until item.payload == string
      item = item.next_list_item
      index += 1

      if index == @size
        index = nil
        break
      end
    end
    return index
  end

  def sorted?
    is_sorted = false
    index = 0

    if @size <= 1
      return true
    else
    item = @first_item
      until item.next_list_item == nil
        is_sorted = item <= item.next_list_item
        item = item.next_list_item
        index += 1
          if is_sorted == false
            return false
          end
      end
    end
    return is_sorted
  end


  def swap_with_next(index)
    if index == @size -1
      raise IndexError
    end
    item1 = get_item(index)
    next_item = item1.next_list_item

    if index == 0
      @first_item = next_item
      item1.next_list_item = item1.next_list_item.next_list_item
    else
      prev_item = get_item(index - 1)
      prev_item.next_list_item = next_item
      item1.next_list_item = item1.next_list_item.next_list_item
    end
    next_item.next_list_item = item1
  end

  def sort
    counter_index = 0
    until self.sorted?
      item1 = get_item(counter_index)
      item2 = get_item(counter_index + 1)
      if item1 < item2
        counter_index += 1
      else
        swap_with_next(counter_index)
        counter_index = 0
      end
    end
    self
  end


#------------PRIVATE-------------------#
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
