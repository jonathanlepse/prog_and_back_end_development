require 'minitest/autorun'

require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end
  
  def test_size
    assert_equal(3, @list.size)
  end
  
  def test_first
    assert_equal(@todo1 ,@list.first)
  end
  
  def test_last
    assert_equal(@todo3, @list.last)
  end
  
  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2,@todo3], @list.to_a)
  end
  
  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end
  
  def test_done
    assert(@list.done?) #you could also test assert_equal(false, @list.done?)
  end
  
  def test_adding_items_as_objects
    array_items = []
    hash_items = {}
    assert_raise(TypeError) {@list.add(1)}
    assert_raise(TypeError) {@list.add("hi")}
    assert_raise(TypeError) {@list.add(array_items)}
    assert_raise(TypeError) {@list.add(hash_items)}
  end
  
  def test_add_method_alias
    new_todo = Todo.new("Walk the dog")
    @list << new_todo #this is executing the << method from our custom class
    todos = @todos << new_todo #this is executing << from array class
      
    assert_equal(todos, @list.to_a)
  end
  
  def test_item_at
    assert_raise(IndexError) {@list.item_at(100)}
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
  end
  
  def test_mark_done_at
    assert_raise(IndexError) {@list.mark_done_at(100)}
    @list.mark_done_at(1)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end
  
  def test_undone_at
    assert_raise(IndexError) {@list.mark_undone_at(100)}
    @todo2.done!
    @list.mark_undone_at(1)
    assert_equal(false, @todo2.done?)
  end
  
  def test_done
    @list.done!
    assert_equal(true, @list.done?)
  end
  
  def test_remove_at
    assert_raise(IndexError) {@list.remove_at(100)}
    assert_equal(@todo2, @list.remove_at(1))
    @list.remove_at(1)
    assert_equal([@todos1, @todos3], @list.to_a)
  end
  
  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, "" #substitute all characters that match the beginnning of the line contains a whitespace character one or more times, with an open string
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    
    assert_equal(output, @list.to_s)
  end
  
  def test_to_s_per_item
    output = <<-OUTPUT.chomp.gsub /^\s+/, "" #substitute all characters that match the beginnning of the line contains a whitespace character one or more times, with an open string
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
    
    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end
  
  def test_all_items_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, "" #substitute all characters that match the beginnning of the line contains a whitespace character one or more times, with an open string
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
    
    @list.mark_all_done
    assert_equal(output, @list.to_s)
  end
  
  def test_each
    result = []
    @list.each { |todo| result << todo}
    assert_equal([@todo1, @todo2, @todo3], result)
  end
  
  def test_another_version_each
    assert_equal(@list, @list.each { |todo| nil}) # we dont want to iterate through anything here just return the object so we pass in nil
  end
  
  def test_select
    @todos.done!
    list = Todo.new(@list.title)
    list.add(@todo1)
    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select { |todo| todo.done?}.to_s)
  end
  
end