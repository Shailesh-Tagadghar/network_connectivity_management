part of 'network_bloc.dart';

@immutable
abstract class NetworkEvent {}

class NetworkInitialCheckEvent extends NetworkEvent {
  final ConnectivityResult connectivityResult;

  NetworkInitialCheckEvent(this.connectivityResult);
}

class NetworkStatusChangedEvent extends NetworkEvent {
  final ConnectivityResult connectivityResult;

  NetworkStatusChangedEvent(this.connectivityResult);
}
