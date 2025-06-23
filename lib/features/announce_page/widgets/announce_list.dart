import 'package:dalily/features/announce_page/logic/get_announce_cubit/get_announce_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_assets.dart';
import '../../../sasa.dart';
import '../announce_page.dart';
import '../logic/get_announce_cubit/get_announce_cubit.dart';

class AnnounceList extends StatelessWidget {
  const AnnounceList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAnnounceCubit,GetAnnounceState>(
      builder: (context, state) {
        return StreamBuilder<List<Map<String, String>>>(
          stream: GetAnnounceCubit.get(context).announcementsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('حدث خطأ');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('لا توجد إعلانات');
            }

            final announcements = snapshot.data!;

            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: announcements.length,
              separatorBuilder: (context, index) => SizedBox(height: 10.h,),
              itemBuilder: (context, index) {
                final item = announcements[index];
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          // Type Icon
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                               gradient: getAnnouncementGradient(item['type']!),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              getAnnouncementIcon(item['type']!),
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 15),

                          // Title and Author
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['title']!,
                                        style: const TextStyle(
                                          color: Color(0xFF2c3e50),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // if (announcement.isImportant)
                                    //   Container(
                                    //     padding: const EdgeInsets.symmetric(
                                    //       horizontal: 8,
                                    //       vertical: 4,
                                    //     ),
                                    //     decoration: BoxDecoration(
                                    //       color: const Color(0xFFff6b6b),
                                    //       borderRadius: BorderRadius.circular(10),
                                    //     ),
                                    //     child: const Text(
                                    //       'مهم',
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //         fontSize: 10,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'بواسطة: ${item['author']}',
                                  style: TextStyle(
                                    color: const Color(0xFF2c3e50).withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Content
                      Text(
                        item['content']!,
                        style: TextStyle(
                          color: const Color(0xFF2c3e50).withOpacity(0.8),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: const Color(0xFF2c3e50).withOpacity(0.5),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item['createdAt']!,
                                style: TextStyle(
                                  color: const Color(0xFF2c3e50).withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
