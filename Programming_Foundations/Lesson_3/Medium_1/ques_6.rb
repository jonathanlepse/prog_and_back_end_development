def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end # the shovel operator is destructive so buffer will be affected everywhere

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end # concatenating a new element onto the array is not destructive so input array outside the method will not change, however b/c you saved the concatenation into a new buffer variable this will return the same as the first method