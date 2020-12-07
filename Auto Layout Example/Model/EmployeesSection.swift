struct EmployeesSection: Comparable {
    var label: String
    var employees: [EnrichedEmployeeData]

    static func < (lhs: EmployeesSection, rhs: EmployeesSection) -> Bool {
        return lhs.label.lowercased() < rhs.label.lowercased()
    }

    static func == (lhs: EmployeesSection, rhs: EmployeesSection) -> Bool {
        return lhs.label.lowercased() == rhs.label.lowercased()
    }
}
