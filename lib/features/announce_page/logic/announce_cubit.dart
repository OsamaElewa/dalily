import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/local/cache_helper.dart';
import 'announce_state.dart';

class AnnounceCubit extends Cubit<AnnounceState> {
  AnnounceCubit() : super(AnnounceInitialState());

  var formKey = GlobalKey<FormState>();

  static AnnounceCubit get(context) => BlocProvider.of(context);

  TextEditingController announceController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  String? dropdownValue;

  void addAnnounce(){
    emit(AnnounceLoadingState());
    FirebaseFirestore.instance.collection('announce').add({
      'title': announceController.text,
      'content': contentController.text,
      'author': authorController.text,
      'type': dropdownValue,
      'createdAt': FieldValue.serverTimestamp(),
    }).then((value) {
      emit(AnnounceSuccessState());
    }).catchError((error){
      emit(AnnounceFailureState(
        error.toString(),
      ));
    });
  }
}
