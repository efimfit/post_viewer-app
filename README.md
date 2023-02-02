# Post_viewer Client app
Client mobile application 

[Link to server app repository](https://github.com/efimfit/post_viewer-server-app-)


![diagram](diagram.png)

___
## Technical description

Flutter 3.3.10 • Dart 2.18.6

Dependency injection was implemented using the `get_it` package + `injectable` package (for code generation).

DI depends on the mode in which the application is running:  `dev`, `prod` or `test`. Depending on this, the possibility of using mock repositories appears.

`flutter_bloc 8.1.1` library is used for implementing BLoC pattern.

`hydrated_bloc` package was used to store the states of cubits responsible for authentication and interaction with posts.

Also for code generation of immutable classes `freezed` package was used.

`Dio` package was used as http client due to support interceptors.

___
## Useful links
[Hydrated_bloc package](https://pub.dev/packages/hydrated_bloc)

[freezed package](https://pub.dev/packages/freezed)

[get_it package](https://pub.dev/packages/get_it)

[injectable package](https://pub.dev/packages/injectable)

[dio package](https://pub.dev/packages/dio)

___

*NOTE* since this project is a pet project, cases of overengineering are possible





