# Wildfront
Wildfront is an iOS application designed for adventure seekers and nature enthusiasts. 
It provides you with a gateway to explore the natural beauty of national parks across the United States. 
This app leverages the National Park Service's API to retrieve information about these parks and presents 
it in an intuitive list and detail format.

## Getting Started
To run this project locally, follow the steps below:

## Prerequisites
Before you begin, ensure you have met the following requirements:

- A Mac computer running macOS Somona.
- Xcode 15, Apple's integrated development environment.
- An iOS 17 compatible device or simulator for running the application.

## Installation
Clone this repository to your local machine using your favorite Git client or by running this command in your terminal:
`git clone https://github.com/philcappelli/wildfront.git`
Open the project in Xcode by double-clicking the .xcodeproj file or running:
Build and run the project by selecting a simulator or a physical device and clicking the "Run" button in Xcode.

Enjoy exploring the national parks and planning your next adventure!

## Features
National Park Information: Discover comprehensive information about various national parks, including their descriptions, locations, and images.

Search Functionality: Easily search for a specific national park by name, making it convenient to find your desired destination.

Intuitive UI: A user-friendly interface that provides a seamless experience, allowing you to navigate through park details effortlessly.

## API Key
To access the National Parks Service APId, an API key is needed. Search the codebase for <INSERT API Key> (within Enviroment.swift) 
and replace it with the valid key.  You can also get your own from the NPS website (https://www.nps.gov/subjects/developer/get-started.htm)

## App Architecture
Wildfront follows the Redux architecture pattern, a predictable state container, to manage the application's state and behavior. The core components of the architecture include:

State: The state represents the current state of the application, which includes information about national parks, loading indicators, and error messages. It is a single source of truth.

Actions: Actions are events that describe changes to the state. In the context of Wildfront, actions include fetching national park data and handling the results, user interactions, and more.

Reducer: The reducer is a pure function that takes the current state and an action, and it returns a new state. This component is responsible for modifying the state based on the provided action.

Middleware: Middleware are functions that intercept actions before they reach the reducer. They can perform asynchronous operations, such as fetching data from an API, and dispatch new actions to update the state accordingly.

Store: The store is responsible for holding the current state, dispatching actions, and notifying the user interface when the state changes. It brings together the state, reducer, and middleware.

## Dependencies
* [NukeUI](https://github.com/kean/Nuke) - Image processing and caching
* [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) - Used to take snapshots of views for testing.
* [ViewInspector](https://github.com/nalexn/ViewInspector) - Used for view interaction testing
