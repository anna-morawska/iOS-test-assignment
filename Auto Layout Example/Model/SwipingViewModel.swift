internal class SwipingViewModel {
    private let networking = Networking()

    internal let prevButtonTitle: String = "PREV"
    internal let nextButtonTitle: String = "NEXT"
    internal var currentPage: Int = 0
    internal var tallinnEmployees: [Employee] = []
    internal var tartuEmployees: [Employee] = []

    internal func getTallinnEmployees() {
        networking.performNetworkTask(endpoint: TallinnJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            self?.tallinnEmployees = response.employees
            print(response.employees)
        }
    }

    internal func getTartuEmployees() {
        networking.performNetworkTask(endpoint: TartuJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            self?.tartuEmployees = response.employees
            print(response.employees)
        }
    }

    internal func incrementCurrentPage() {
        currentPage = min(currentPage + 1, pages.count - 1)
    }

    internal func decrementCurrentPage() {
        currentPage =  max(currentPage - 1, 0)
    }

    internal let pages =  [
        Page(
            imageName: "Onboarding_1",
            headerText: "Morbi blandit cursus risus at ultrices mi tempus imperdiet nulla",
            description: "Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl vel pretium"),
        Page(
            imageName: "Onboarding_2",
            headerText: "Elementum pulvinar etiam non quam lacus suspendisse",
            description: "maecenas pharetra convallis posuere morbi leo urna molestie at elementum eu facilisis sed odio morbi quis commodo odio aenean sed"),
        Page(
            imageName: "Onboarding_3",
            headerText: "Eget dolor morbi non arcu risus quis varius quam quisque",
            description: "eget lorem dolor sed viverra ipsum nunc aliquet bibendum enim facilisis gravida neque convallis a cras semper auctor neque vitae"),
        Page(
            imageName: "Onboarding_4",
             headerText: "Purus in massa tempor nec feugiat nisl pretium fusce id",
             description: "elit at imperdiet dui accumsan sit amet nulla facilisi morbi tempus iaculis urna id volutpat lacus laoreet non curabitur gravida"),
        Page(
            imageName: "Onboarding_5",
            headerText: "Aliquet bibendum enim facilisis gravida neque",
            description: "sed blandit libero volutpat sed cras ornare arcu dui vivamus arcu felis bibendum ut tristique et egestas quis ipsum suspendisse")
    ]
}
