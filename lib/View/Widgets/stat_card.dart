import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconColor;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    required this.icon,
    this.iconColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          // Icon
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 28, color: iconColor),
          ),
          
          SizedBox(width: 16),
          
          // Title and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor,
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
