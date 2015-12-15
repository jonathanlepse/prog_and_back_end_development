munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash) 
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

def other_mess_with_demographics(demo_hash) # this demo hash method has to be reassigned inside the method body so as to not effect the original munsters hash.
  demo_hash = {} 
  demo_hash.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
  demo_hash
end

p mess_with_demographics(munsters)
p other_mess_with_demographics(munsters)