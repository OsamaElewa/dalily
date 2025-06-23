import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget {
  ClassCard({super.key, required this.icon, required this.title, required this.colors});
  final IconData icon;
  final String title;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: colors,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: colors[0].withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2c3e50),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: colors[0],
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


final gradients = [
  [Color(0xFF667eea), Color(0xFF764ba2)],
  [Color(0xFF4facfe), Color(0xFF00f2fe)],
  [Color(0xFFa8edea), Color(0xFFfed6e3)],
  [Color(0xFFffecd2), Color(0xFFfcb69f)],
];
final teams = [
  {'name': 'الفرقة الاولي', 'members': '45 عضو', 'icon': Icons.person},
  {'name': 'الفرقة الثانية', 'members': '38 عضو', 'icon': Icons.group},
  {'name': 'الفرقة الثالثة', 'members': '52 عضو', 'icon': Icons.groups},
  {'name': 'الفرقة الرابعة', 'members': '41 عضو', 'icon': Icons.group_work},
];

// const Text(
// 'اختر الفريق',
// style: TextStyle(
// fontSize: 22,
// fontWeight: FontWeight.bold,
// color: Color(0xFF2c3e50),
// ),
// ),
// const SizedBox(height: 5),
// Text(
// 'اختر الفريق المناسب لك من القائمة أدناه',
// style: TextStyle(
// fontSize: 14,
// color: Color(0xFF2c3e50).withOpacity(0.7),
// ),
// ),