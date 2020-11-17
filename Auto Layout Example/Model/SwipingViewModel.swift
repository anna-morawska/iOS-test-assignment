internal class SwipingViewModel {
    internal let prevButtonTitle: String = "PREV"
    internal let nextButtonTitle: String = "NEXT"
    internal let currentPage: Int = 0

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
