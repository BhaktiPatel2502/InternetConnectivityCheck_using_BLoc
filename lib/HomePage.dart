import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connectivity_check/Bloc/InternetBloc.dart';
import 'package:internet_connectivity_check/Bloc/InternetState.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc,InternetState>(
            listener: (context,state){
              if(state is InternetGainedState){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Internet Connected!"),backgroundColor: Colors.green,));
              }
              else if(state is InternetLostState){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Internet not Connected!"),backgroundColor: Colors.red,));
              }
            },
            builder: (context, state)
            {
              if(state is InternetGainedState){
                return Text('Connected');
              }
              else if(state is InternetLostState){
                return Text('Not Connected');
              }
              else{
                return Text("Loading...");
              }
            },
          ),
        ),
      ),

    );
  }
}
