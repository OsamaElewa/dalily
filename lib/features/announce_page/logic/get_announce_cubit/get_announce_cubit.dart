import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'get_announce_state.dart';

class GetAnnounceCubit extends Cubit<GetAnnounceState> {
  GetAnnounceCubit() : super(GetAnnounceInitialState());


  var formKey = GlobalKey<FormState>();

  static GetAnnounceCubit get(context) => BlocProvider.of(context);


  Stream<List<Map<String, String>>> announcementsStream() async* {
    final collection = FirebaseFirestore.instance.collection('announce');

    // حذف الدوكومنتات الأقدم من 24 ساعة
    final snapshot = await collection.get();
    final now = DateTime.now();

    for (var doc in snapshot.docs) {
      final createdAt = doc['createdAt']?.toDate();
      if (createdAt != null) {
        final difference = now.difference(createdAt);
        if (difference.inHours >= 24) {
          await doc.reference.delete();
        }
      }
    }

    // إرجاع الستريم مع التنسيق
    yield* collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final title = doc['title'] as String? ?? '';
        final content = doc['content'] as String? ?? '';
        final author = doc['author'] as String? ?? '';
        final type = doc['type'] as String? ?? '';
        final timestamp = doc['createdAt'];
        final dateTime = timestamp?.toDate();
        String formattedDate = '';

        if (dateTime != null) {
          formattedDate = DateFormat.yMMMMd('ar')
              .add_jm()
              .format(dateTime);
        }

        return {
          'title': title,
          'content': content,
          'author': author,
          'type': type,
          'createdAt': formattedDate,
        };
      }).toList();
    });
  }
}
