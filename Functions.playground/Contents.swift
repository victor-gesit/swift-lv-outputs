func tellDataType( _ input: Any ) -> String {
        let result = String(describing: type(of: input))
        return "The supplied parameter is of type \(result)"
}

print(tellDataType(25))
print(tellDataType("Twenty Five"))
print(tellDataType([25: "Hello"]))
print(tellDataType((25, "Hello")))
