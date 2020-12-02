protocol Searchable {
    func matches(query: String) -> Bool
}

extension String: Searchable {
    func matches(query: String) -> Bool {
        return self.lowercased().contains(query.lowercased())
    }
}

extension Array: Searchable where Element: Searchable {
    func matches(query: String) -> Bool {
        self.contains(where: { $0.matches(query: query) })
    }
}
