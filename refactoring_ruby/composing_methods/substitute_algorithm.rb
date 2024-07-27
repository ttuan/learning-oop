def found_friends(people)
  friends = []

  people.each do |person|
    if(person == "Don")
      friends << "Don"
    end
    if(person == "John")
      friends << "John"
    end
    if(person == "Kent")
      friends << "Kent"
    end
  end

  return friends
end

#===============================================================================
def found_friends
  people.select do |person|
    %w(Don John Kent).include?(person)
  end
end
