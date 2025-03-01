import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLevel = "Beginner";
  List<String> levels = ["Beginner", "Intermediate", "Advanced"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Wavy Orange Background
          ClipPath(
            clipper: OrangeWaveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(color: Colors.orange.shade400),
            ),
          ),

          // Two Background Circles
          Positioned(
            top: 80,
            left: 40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            top: 130,
            right: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        Icon(Icons.navigate_before, color: Colors.white),
                        Spacer(),
                        Text("Curse", style: TextStyle(color: Colors.white, fontSize: 20)),
                        Spacer(),
                        Icon(Icons.more_vert, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Language Title
                    Text(
                      "Spanish",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Dropdown & Progress Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Level Selector
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 40,
                          width: 130,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: PopupMenuButton<String>(
                            onSelected: (String value) {
                              setState(() {
                                selectedLevel = value;
                              });
                            },
                            itemBuilder: (BuildContext context) {
                              return levels.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  selectedLevel,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down, color: Colors.orange),
                              ],
                            ),
                          ),
                        ),

                        // Progress Circle
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    value: 0.43,
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  ),
                                ),
                                Text("43%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text("Complete", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    // Milestones
                    Row(
                      children: [
                        Icon(Icons.diamond, color: Colors.red, size: 30),
                        Icon(Icons.diamond, color: Colors.red, size: 30),
                        SizedBox(width: 5),
                        Text("2 Milestones", style: TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),

              // Course Categories Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildCategoryCard("Basics", Icons.article, 4, 5, Colors.orange),
                      _buildCategoryCard("Occupations", Icons.work, 1, 5, Colors.red),
                      _buildCategoryCard("Conversation", Icons.chat, 3, 5, Colors.blue),
                      _buildCategoryCard("Places", Icons.place, 1, 5, Colors.green),
                      _buildCategoryCard("Family members", Icons.group, 3, 5, Colors.purple),
                      _buildCategoryCard("Foods", Icons.food_bank, 2, 5, Colors.blueAccent),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Function to Build Category Cards
  Widget _buildCategoryCard(String title, IconData icon, int progress, int total, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text("$progress / $total"),
            LinearProgressIndicator(
              value: progress / total,
              color: color,
              backgroundColor: color.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for Wavy Background
class OrangeWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 180);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 180);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
