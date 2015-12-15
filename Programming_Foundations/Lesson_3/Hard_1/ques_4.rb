def UUID_generator
  characters = []
  (0..9).each { |digits| characters << digits.to_s}
  ("a".."f").each { |letters| characters << letters}
  
  uuid = ' '
  sections = [8,4,4,4,12]
  sections.each_with_index do |number, index|
    number.times {uuid += characters.sample}
    uuid += '-' unless index >= sections.siz -1
  end
end
