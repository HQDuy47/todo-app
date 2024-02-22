# Flutter TODO App

This is a simple Flutter application to manage TODO list items. The app allows users to create new TODO items, select specific time for the TODO, view TODO list based on different categories, search within the TODO list, receive notifications before the TODO deadline, and mark a TODO as completed.

## Getting Started

To install the app, you need to have Flutter development environment set up on your machine. Then, you can follow these steps:

1. Clone this repository to your machine:

 ```bash
   git clone https://github.com/your-username/flutter-todo-app.git
 ```

2. Navigate to the project directory:

 ```bash
   cd flutter-todo-app
 ```

3. Install the necessary dependencies:

 ```bash
   flutter pub get
 ```

4. Run the app on a device or emulator:
   
 ```bash
   flutter run
 ```

## Features

-  Create new TODO: Users can create a new TODO item, including selecting a specific time for the TODO.
-  View TODO list: Users can view the TODO list based on different categories such as All TODOs, Today's TODOs, Upcoming TODOs.
-  Search TODOs: Users can search within the TODO list by title or content of the TODO.
-  Receive notifications: Users will receive notifications 10 minutes before the deadline of a TODO.
-  Mark TODO as completed: Users can mark a TODO as completed and remove it from the TODO list.

## Dependencies

- flutter_local_notifications: Used for sending notifications to users before the deadline of a TODO.
- flutter_local_notifications: ^9.1.4
- flutter_datetime_picker: ^1.5.1
- timezone: ^0.8.0
- shared_preferences: ^2.2.2
- hive: ^2.2.3

## Demo

https://www.youtube.com/watch?v=ngh3U_LzLqY
