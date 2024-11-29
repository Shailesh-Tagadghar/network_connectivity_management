import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_connectivity_management/Bloc/Network/bloc/network_bloc.dart';
import 'package:network_connectivity_management/Bloc/Post/bloc/post_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Posts'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, networkState) {
          String networkStatus = 'Checking network status...';
          String networkType = '';

          if (networkState is NetworkConnected) {
            networkStatus = 'Connected';
            networkType = 'Network Type: ${networkState.networkType}';
          } else if (networkState is NetworkDisconnected) {
            networkStatus = 'Disconnected';
            networkType = 'No network connection';
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '$networkStatus\n$networkType',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostFechingLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostFetchingSuccessfulState) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[700],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'id : ${state.posts[index].id}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'title : ${state.posts[index].title}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is PostFechingErrorState) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(
                      child: Text('Press the button to fetch posts.'));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
