part of 'network_bloc.dart';

@immutable
abstract class NetworkState {}

final class NetworkInitial extends NetworkState {}

class NetworkConnected extends NetworkState {
  final String connectionType;

  NetworkConnected(this.connectionType);
}

class NetworkDisconnected extends NetworkState {}
