import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  NetworkBloc(this._connectivity) : super(NetworkInitial()) {
    on<NetworkStatusChangedEvent>(_onNetworkStatusChanged);
    on<NetworkInitialCheckEvent>(_onNetworkInitialCheck);

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        add(NetworkStatusChangedEvent(connectivityResult));
      },
    );
  }

  // Handles the network status change event
  Future<void> _onNetworkStatusChanged(
      NetworkStatusChangedEvent event, Emitter<NetworkState> emit) async {
    final connectivityResult = event.connectivityResult;
    if (connectivityResult == ConnectivityResult.none) {
      emit(NetworkDisconnected());
    } else {
      final networkType = await _getNetworkType(connectivityResult);
      emit(NetworkConnected(connectivityResult, networkType));
    }
  }

  // Checks the initial network status
  Future<void> _onNetworkInitialCheck(
      NetworkInitialCheckEvent event, Emitter<NetworkState> emit) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      emit(NetworkDisconnected());
    } else {
      final networkType = await _getNetworkType(connectivityResult);
      emit(NetworkConnected(connectivityResult, networkType));
    }
  }

  Future<String> _getNetworkType(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile) {
      return 'Mobile Data'; // Dynamic label
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return 'Wi-Fi';
    }
    return 'Unknown';
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
