import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity connectivity;

  NetworkBloc(this.connectivity) : super(NetworkInitial()) {
    on<NetworkEvent>((event, emit) async {
      final result = await connectivity.checkConnectivity();
      emit(_getNetworkState(result as ConnectivityResult));

      connectivity.onConnectivityChanged.listen((result) {
        add(CheckNetworkStatus());
      });
    });
  }

  NetworkState _getNetworkState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return NetworkConnected('WiFi');
      case ConnectivityResult.mobile:
        return NetworkConnected('Mobile');
      case ConnectivityResult.none:
        return NetworkDisconnected();
      default:
        return NetworkDisconnected();
    }
  }
}
