#  SpaceFlightNews App

- Network API Resource Path: https://api.spaceflightnewsapi.net/v4/docs/#/

## Features:
- The app utilizes the remote API mentioned above to showcase three tabs: Articles, Blogs, and Reports.
- Each of these tabs includes an individual filter to refine the API response based on specific criteria.

### Performance, Modern Concurrency, complete SwiftUI:
- This project uses SwiftUI with the latest API available from the frameworks.
- It also leverages Swift concurrency APIs and techniques to significantly enhance runtime performance.
- To optimize compile-time performance, the project efficiently uses explicit type annotations. This assists the Swift compiler in faster project compilation by adopting a modular approach to achieve parallel compilation.

 ### Readability:
- The project maintains consistent coding patterns across all its features.
- Each feature module clearly defines an action system outlining the actions users can perform.
- Each feature module declares a separate State object to simplify readability and testability consistently.
- For review, navigate to the SpaceFlight package (referred to as "a1" below) -> Sources -> ArticlesFeature directory.

### Maintainability, Modular:
- This project uses local Swift packages for each feature, derived for fine-grained functionality.
- This approach helps locate particular features or functionalities within a single directory.
- By selecting the target scheme from the Xcode scheme selection menu, one can examine a single feature. This ensures that only one feature is executed by Xcode, thereby reducing compile time.
- For review, one can select the `ArticlesFeature` scheme from the Xcode scheme selection menu and open the file `ArticlesView`.
- If Xcode's preview canvas for the `ArticlesView` is not open, please open the preview canvas and resume the preview.
- Xcode now compiles the single target module and displays the screen in the preview.
- This process occurs within Xcode without needing to open the whole simulator app, thus enhancing maintainability by default.


### Testability, Unit Test:
- Since the project uses local Swift packages for fine-grained features, it also allows writing unit tests for each feature in isolation.
- For review, one can explore the Tests directory inside the SpaceFlight package.
- There are 4 test targets available.
- To test each target in isolation, one can select the test target scheme from the Xcode scheme selection menu and run the tests (or use the Command+U shortcut).
- To test all test targets at once, the project utilizes a Test plan called `SpaceFlightNews.xctestplan`.
- To run all tests, select the main project schema from the Xcode scheme selection menu, and then press Command + U.
- Additionally, the project uses a specialized dependency system to provide on-demand test values for remote API calls without actually performing the network calls.
- For review, one can open the `ArticlesFeatureTest` file and look for the `withDependencies:` closure, where network results can be easily provided for various conditions.

|-------------------------------------------------------------------------------|
| - Feature Test -              | - Test method -              | - Duration -   |
|-------------------------------------------------------------------------------|
| AppTabsFeatureTests           | test_Tab_Filter_Integration  | 0.0180 seconds |
|                               |-----------------------------------------------|
|                               | test_TabSelection            | 0.0047 seconds |
|-------------------------------------------------------------------------------|
| ArticleNavigationFeatureTests | testNavigation               | 0.0190 seconds |
|-------------------------------------------------------------------------------|
| ArticlesFeatureTests          | test_Article_FilterButton    | 0.0290 seconds |
|                               |-----------------------------------------------|
|                               | test_Article_OnAppear_Failure| 0.0029 seconds |
|                     ----------------------------------------------------------|
|                     | test_Article_OnAppear_NextPage_Failure | 0.0080 seconds |
|                 --------------------------------------------------------------|
|                 | test_Article_OnAppear_NextPage_OpenDetails | 0.0075 seconds |
|-------------------------------------------------------------------------------|
| FilterFeatureTests            | testFormApply                | 0.0170 seconds |
|                               |-----------------------------------------------|
|                               | testFormReset                | 0.0057 seconds |
|                               |-----------------------------------------------| 
|                               | testForm                     | 0.0048 seconds |
|-------------------------------------------------------------------------------|
|                                                              |                |
|                          ** TOTAL **                         | 0.1166 seconds |
|                                                              |                |
|-------------------------------------------------------------------------------|

- All test plan tests execute in just under 0.2 seconds without invoking the network API call, and all test case results show 100% accuracy.

### Scalability:
- This project employs a compositional technique to integrate all individual isolated features into a cohesive, functioning application.
- Inspired by the mathematical concept of divide and integrate, the process begins by breaking down features into fine-grained functionalities.
- Each feature is developed with strong isolation, minimizing unnecessary dependencies on other features.
- These isolated features are then integrated into a composite feature representing the entire app.
- For further understanding, please refer to the `AppTabsFeature`.
- With this approach, future feature requests only require focusing on the specific feature itself, facilitating integration with the relevant parent feature and providing scalability at any level.
- For a real-world example, visit the Arc browser project by the Browser Company (referenced as a2, a3, a4 below).
- Additionally, this technique enables the implementation of other features such as Widgets, Shortcuts Intents, Live Activities, etc., with ease.
- Using a composable approach, integration tests can also be written effortlessly.
- For review, please visit the `ArticlesFeatureTests`'s `test_Article_FilterButton` method and `AppTabsFeatureTests`'s `test_Tab_Filter_Integration` method.

### Simplicity:
- This project offers straightforward and consistent methods for integrating features.
- The architecture is well-developed, drawing inspiration from SwiftUI itself.
- For instance, while SwiftUI utilizes Environments to pass data around views seamlessly, this project extends this functionality with its Dependency system.
- This Dependency system, matching SwiftUI's Environment API, allows for easy injection of mock data on demand, enhancing not only unit testability but also Xcode preview canvas usage.
- For review, please see the preview code in `ArticlesView` at the bottom of the file.

### SOLID Principles:
- Upon reviewing the project source code, one will find adherence to each individual SOLID principle.
- Each fine-grained feature performs a single job, adhering to the Single Responsibility Principle.
- Dependencies can be overridden for previews and test cases, demonstrating compliance with the Open-Closed Principle and Liskov Substitution Principle.
- The Dependencies mechanism, using `@Dependency(\.appService)`, employs protocol witnesses for on-demand method override.
- PreviewDataProvider serves as a simple example of the Interface Segregation Principle, with further improvements available.

### Annotations:
- a1. The SpaceFlight Package can be located by identifying an orange-colored Cardboard box icon in the File Hierarchy Panel on the left side of the Xcode window.
- a2. The Arc browser project utilizes Swift and TCA, showcased. (https://www.youtube.com/watch?v=Xa_fNuaSE_I).
- a3. Arc browser shares code with the Windows OS thanks to TCA, as referenced(https://x.com/darinwf/status/1785360437086949789).
- a4. Explore other TCA showcase projects (https://github.com/pointfreeco/swift-composable-architecture/discussions/1145).
