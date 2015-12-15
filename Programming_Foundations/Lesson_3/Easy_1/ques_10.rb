flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flint_hash = {}

flintstones.each_with_index do |name, idx|
  flint_hash[name] = idx
end

def convert_to_hash(array)
  flint_hash = {}
  array.each_with_index do |name, idx|
    flint_hash[name]= idx
  end
  flint_hash
end

puts convert_to_hash(flintstones)