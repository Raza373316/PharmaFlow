import 'package:flutter/material.dart';

class SalesGraph extends StatelessWidget {
  final List<Map<String, dynamic>> weeklyData;

  const SalesGraph({
    Key? key,
    this.weeklyData = const [
      {"day": "Mon", "sales": 5000},
      {"day": "Tue", "sales": 8000},
      {"day": "Wed", "sales": 6500},
      {"day": "Thu", "sales": 9000},
      {"day": "Fri", "sales": 12000},
      {"day": "Sat", "sales": 15000},
      {"day": "Sun", "sales": 11000},
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Find max sales for scaling
    int maxSales = weeklyData.map<int>((e) => e["sales"] as int).reduce((a, b) => a > b ? a : b);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 6,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Weekly Sales Chart",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          SizedBox(height: 20),
          
          // Chart
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                weeklyData.length,
                (index) {
                  var data = weeklyData[index];
                  int sales = data["sales"];
                  String day = data["day"];
                  
                  // Calculate bar height based on max sales
                  double barHeight = (sales / maxSales) * 150;
                  
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Bar
                      Container(
                        width: 35,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color: Color.lerp(Colors.blue.shade300, Colors.blue.shade800, sales / maxSales),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.blue.shade200.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 8),
                      
                      // Day label
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      
                      SizedBox(height: 4),
                      
                      // Sales amount
                      Text(
                        "Rs.${(sales / 1000).toStringAsFixed(1)}k",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Legend/Info
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: Colors.blue, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Sales are trending upward this week",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
