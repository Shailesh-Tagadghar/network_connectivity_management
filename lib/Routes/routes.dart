// Define your routes here
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_connectivity_management/Bloc/Post/bloc/post_bloc.dart';
import 'package:network_connectivity_management/Presentation/Post_API_3_Attempt/post_page.dart';

class AppRoutes {
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (_) => PostBloc()..add(PostInitialFetchEvent()),
              child: const PostPage(),
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const PostPage();
          },
        );
    }
  }
}
