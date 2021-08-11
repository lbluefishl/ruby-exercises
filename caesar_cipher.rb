

def caesar_cipher(string, shift)
  lowercase_alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
  upcase_alphabet = lowercase_alphabet.map{|e| e.upcase}
  new_array = []

  split_string = string.split('')
  split_string.each {|e|  
  if lowercase_alphabet.index(e) 
    new_array.push(lowercase_alphabet[(lowercase_alphabet.index(e)+shift)%26])
  elsif upcase_alphabet.index(e) 
    new_array.push(upcase_alphabet[(upcase_alphabet.index(e)+shift)%26])
  else new_array.push(e)
  end}
  p new_array.join
end

caesar_cipher("What a string!",-1)
