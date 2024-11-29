// widgets/connectivity_status.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_connectivity_management/Bloc/Network/bloc/network_bloc.dart';

class ConnectivityStatus extends StatelessWidget {
  const ConnectivityStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkConnected) {
          return Text('Connected: ${state.connectionType}');
        } else if (state is NetworkDisconnected) {
          return const Text('No Internet');
        } else {
          return const Text('Checking...');
        }
      },
    );
  }
}
