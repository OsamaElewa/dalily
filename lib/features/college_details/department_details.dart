import 'package:flutter/material.dart';

class DepartmentDetails extends StatelessWidget {
  DepartmentDetails({
    Key? key,
    required this.seen,
    required this.message,
    required this.target,
    required this.department,
  }) : super(key: key);
  final String seen, message, target, department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        department,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),

              // Main Content Container
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Department Vision Section
                        _buildSectionCard(
                          title: 'رؤية القسم',
                          content:
                          seen,
                          icon: Icons.visibility,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Department Mission Section
                        _buildSectionCard(
                          title: 'رسالة القسم',
                          content:
                          message,
                          icon: Icons.school,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Department Mission Section
                        _buildSectionCard(
                          title: 'اهداف القسم',
                          content:
                          target,
                          icon: Icons.queue_play_next,
                          gradient: const LinearGradient(
                            colors: [Color(0xFFa8edea), Color(0xFFfed6e3)],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Department Goals Header

                        // Bottom Statistics Card
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
    required Gradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(25),
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
        children: [
          // Icon Header
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2c3e50),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 15),

          // Content
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF2c3e50),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(String text, IconData icon, int index) {
    final gradients = [
      const LinearGradient(colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
      const LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)]),
      const LinearGradient(colors: [Color(0xFFa8edea), Color(0xFFfed6e3)]),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: gradients[index % gradients.length],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),

          const SizedBox(width: 20),

          // Text
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2c3e50),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}




// import 'package:flutter/material.dart';
//
// class DepartmentDetails extends StatelessWidget {
//   DepartmentDetails({super.key, required this.seen, required this.message, required this.target});
//   final String seen , message , target;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(onPressed: () {
//           Navigator.pop(context);
//         }, icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,)),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.all(Radius.circular(15)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Text('رؤية القسم',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                     SizedBox(height: 20,),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           title: Text(seen,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20,),
//                     Text('رسالة القسم',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                     SizedBox(height: 20,),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           title: Text(message,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20,),
//                     Text('اهداف القسم',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                     SizedBox(height: 20,),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListTile(
//                           title: Text(target,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
