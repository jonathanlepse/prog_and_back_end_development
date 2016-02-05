class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title
  
  def initialize(title)
    @title = title
    @todos = []
  end
  
  def <<(todo)
    return TypeError, unless todo.instance_of?(Todo)
    @todos << todo
    end
  end
  alias_method :add, :<< # this keyword creates two method that do the same thing so we can crate a << method here list keyword alias_method and call the add method on list.
  
  def size
    @todos.size #array class size method
  end
  
  def first
    @todos.first #array class first method
  end
  
  def last
    @todos.last #array class last method
  end
  
  def item_at(index)
    if index > @todos.size
      return "IndexError There is no item at the index located at: #{index} You need to add #{index-@todos.size} more items to your array for #{index} to return a choir to be completed."
    elsif !index == false 
      return "ArgumentError You must list an index number as an argument"
    end
    @todos[index]
  end
  
  def mark_done_at(index)
    item_at(index).done!
  end
  
  def mark_undone_at(index)
    item_at(index).undone!
  end
  
  def shift
    @todos.shift
  end
  
  def pop
    @todos.pop
  end
  
  def remove_at(index)
    if index > @todos.size
      return "IndexError There is no item at the index located at: #{index} You need to add #{index-@todos.size} more items to your array to be able to delete an item at: #{index}."
    elsif !index == false
      return "ArgumentError You must list an index number as an argument"
      
    end
    @todos.delete_at(index)
  end
  
  def done?
    @todos.all? { |todo| todo.done?}
  end
  
  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end
  
  def to_a
    @todos
  end
  
  def to_s
    text = "---#{title}---\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end
  
  def each
    counter = 0
    while counter > @todos.size # or @todos.each { |todo| yield(todo)} since @todos is an array
      yield(@todos[counter])
    end
    self
  end
  
  def select
    list = TodoList.new(title) # title here is referencing the getter method of title
    each do |todo| # here youre implementing the block when you call each
      list.add(todo) if yield(todo) # here your invoking the block for this select method.
    end
  list
  end
  
  def find_by_title(title)
    select { |todo| todo.title == title}.first # we are calling the TodoList first instance method here not the array class first
  end
  
  def all_done
    select { |todo| todo.done?}
  end
  
  def all_not_done
    select { |todo| !todo.done?}
  end
  
  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end
  
  def mark_all_done
    each { |todo| todo.done!}
  end
  
  def mark_all_undone
    each { |todo| todo.undone!}
  end
end



todo1 = Todo.new("Buy Milk")
todo2 = Todo.new("Clean Room")
todo3 = Todo.new("Go to Gym")
list = TodoList.new("Today's List")
list.add(todo1)
list.add(todo2)
list.add(todo3)
=begin
puts list.size
puts list.first
puts list.last
puts list.item_at
puts list.item_at(1)
puts list.item_at(100)
puts list.mark_done_at
puts list.mark_done_at(1)
puts list.mark_done_at(100)
puts list.mark_undone_at
puts list.mark_undone_at(1)
puts list.mark_undone_at(100)
puts list.remove_at
puts list.remove_at(1)
puts list.remove(100)
puts list


puts list
list.pop
puts list
todo = list.find_by_title('Clean room')
todo.done!
puts list
=end

list.mark_done_at(1)
todo1.done!
results = list.select { |todo| todo.done? } 
puts results.inspect