import 'dart:async';


import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:internet_connectivity_check/Bloc/InternetEvent.dart';

import 'InternetState.dart';

class InternetBloc extends Bloc<InternetEvent,InternetState>{

  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState())
  {
    on<InternetLostEvent>((event,emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event,emit) => emit(InternetGainedState()));

    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        add(InternetGainedEvent());
      }
      else{
        add(InternetLostEvent());
      }
    });
}

 @override
  Future<void> close() {
   connectivitySubscription?.cancel();
   return super.close();
 }
}