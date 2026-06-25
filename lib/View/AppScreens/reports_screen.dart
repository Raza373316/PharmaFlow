import 'package:flutter/material.dart';
import 'package:pharmacymanagement/View/Custom%20Widget/CustomText.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  // Sample data
  final int todaySales = 15000;
  final int monthlySales = 240000;

  final List<Map<String, dynamic>> topSellingMedicines = [
    {"name": "Panadol", "sales": 150},
    {"name": "Calpol", "sales": 120},
    {"name": "Aspirin", "sales": 95},
  ];

  final List<Map<String, dynamic>> weeklyChartData = [
    {"day": "Mon", "sales": 5000},
    {"day": "Tue", "sales": 8000},
    {"day": "Wed", "sales": 6500},
    {"day": "Thu", "sales": 9000},
    {"day": "Fri", "sales": 12000},
    {"day": "Sat", "sales": 15000},
    {"day": "Sun", "sales": 11000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Reports",
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomText(text: "Refreshing data...", color: Colors.white),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.lightBlue.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today Sales Card
              _buildStatCard(
                title: "Today Sales",
                value: "Rs. ${todaySales.toString()}",
                backgroundColor: Colors.green.shade50,
                textColor: Colors.green.shade700,
                icon: Icons.today,
                iconColor: Colors.green,
              ),

              // Monthly Sales Card
              _buildStatCard(
                title: "Monthly Sales",
                value: "Rs. ${monthlySales.toString()}",
                backgroundColor: Colors.blue.shade50,
                textColor: Colors.blue.shade700,
                icon: Icons.calendar_today,
                iconColor: Colors.blue,
              ),

              // Year Sales Card
              _buildStatCard(
                title: "Year Sales",
                value: "Rs. 2,880,000",
                backgroundColor: Colors.purple.shade50,
                textColor: Colors.purple.shade700,
                icon: Icons.trending_up,
                iconColor: Colors.purple,
              ),

              SizedBox(height: 20),

              // Top Selling Medicines Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Row(
                      children: [
                        Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
                        SizedBox(width: 8),
                        CustomText(
                          text: "Top Selling Medicines",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // Medicines List
                    Container(
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
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: List.generate(
                          topSellingMedicines.length,
                              (index) => _buildMedicineListItem(
                            position: index + 1,
                            medicineName: topSellingMedicines[index]["name"],
                            salesCount: topSellingMedicines[index]["sales"],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Sales Graph Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.show_chart, color: Colors.blue, size: 24),
                        SizedBox(width: 8),
                        CustomText(
                          text: "Sales Analytics",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // Graph
                    _buildSalesGraph(),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Additional Info Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Quick Stats",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),

                    SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuickStat("Total Orders", "287", Colors.white),
                        _buildQuickStat("Avg Order", "Rs. 835", Colors.white),
                        _buildQuickStat("Growth", "+15%", Colors.white),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color backgroundColor,
    required Color textColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 28, color: iconColor),
          ),

          SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 6),
                CustomText(
                  text: value,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineListItem({
    required int position,
    required String medicineName,
    required int salesCount,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Position Badge
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _getPositionColor(position),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomText(
                text: "$position",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          SizedBox(width: 12),

          // Medicine Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: medicineName,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                CustomText(
                  text: "Sales: $salesCount units",
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),

          // Sales Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _getPositionColor(position).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: CustomText(
              text: "$salesCount",
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: _getPositionColor(position),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPositionColor(int pos) {
    switch (pos) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.orange.shade700;
      default:
        return Colors.blue;
    }
  }

  Widget _buildSalesGraph() {
    int maxSales = weeklyChartData.map<int>((e) => e["sales"] as int).reduce((a, b) => a > b ? a : b);

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
          CustomText(
            text: "Weekly Sales Chart",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),

          SizedBox(height: 20),

          // Chart
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                weeklyChartData.length,
                    (index) {
                  var data = weeklyChartData[index];
                  int sales = data["sales"];
                  String day = data["day"];

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
                      CustomText(
                        text: day,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),

                      SizedBox(height: 4),

                      // Sales amount
                      CustomText(
                        text: "Rs.${(sales / 1000).toStringAsFixed(1)}k",
                        fontSize: 10,
                        color: Colors.grey.shade600,
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
                  child: CustomText(
                    text: "Sales are trending upward this week",
                    fontSize: 12,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 11,
          color: color.withOpacity(0.8),
        ),
        SizedBox(height: 4),
        CustomText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ],
    );
  }
}