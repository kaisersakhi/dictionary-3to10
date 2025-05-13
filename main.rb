require("json")

INPUT_FILE="words_dictionary.json"
OUTPUT_FILES_PREFIX="words_part"
MIN_LENGTH=3
MAX_LENGTH=11
NUMBER_OF_PARTS=12
RADOMIZE_WORDS=true

picked_words = []

file_data = File.read(INPUT_FILE)
data = JSON.parse(file_data)

data.to_a.each do |item|
  word = item[0]
  if word.length > 3 && word.length < 11
    picked_words << word
  end
end

picked_words.shuffle! if RADOMIZE_WORDS

k = (picked_words.length / NUMBER_OF_PARTS.to_f).ceil

parted_words = picked_words.each_slice(k).to_a

parted_words.each_with_index do |words, part_number|
  File.write(OUTPUT_FILES_PREFIX + "_#{part_number + 1}.json", words.to_json)
end

File.write("part_size.json", {partSize: NUMBER_OF_PARTS}.to_json)
