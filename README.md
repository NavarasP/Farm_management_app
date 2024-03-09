# cluck_connect

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## File Structure

```lib
lib/
|__ agent/
|   |__ chatpage_agent.dart
|   |__ chatroom_agent.dart
|   |__ daily_updates.dart
|   |__ details_agent.dart
|   |__ home_agent.dart
|   |__ transaction_agent.dart
|__ authentication/
|   |__ login.dart
|   |__ signup.dart
|   |__ splash_screen.dart
|   |__ welcoming_screen.dart
|__ farmer/
|   |__ chatpage_farmer.dart
|   |__ details_farmer.dart
|   |__ home_farmer.dart
|   |__ stockdetails_farmer.dart
|   |__ transaction_farmer.dart
|__ services/
|   |__ api/
|   |   |__ agent_api.dart
|   |   |__ authentication_api.dart
|   |   |__ farmers_api.dart
|   |__ models/
|   |   |__ agent_model.dart
|   |   |__ authentication_model.dart
|   |   |__ farmer_model.dart
|   |__ widgets.dart
|__ main.dart
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  convex_bottom_bar: ^3.2.0
  image_picker: ^1.0.7
  http: ^1.2.1
  shared_preferences: ^2.2.2
```