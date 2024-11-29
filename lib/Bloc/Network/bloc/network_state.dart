part of 'network_bloc.dart';

@immutable
abstract class NetworkState {}

final class NetworkInitial extends NetworkState {}

class NetworkConnected extends NetworkState {
  final ConnectivityResult connectivityResult;
  final String networkType;

  NetworkConnected(this.connectivityResult, this.networkType);
}

class NetworkDisconnected extends NetworkState {}
