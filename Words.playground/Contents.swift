extension String {
    func words() ->  [String] {
        let subStrings = self.split(separator: " ")
        let strings = subStrings.map { (word) -> String in
            String(word)
        }
        return strings
    }
}

let sentence = "Obi is a boy"
print(sentence.words())
