import 'package:flutter/material.dart';

class MedicineListItem extends StatelessWidget {
  final String medicineName;
  final int salesCount;
  final int position;

  const MedicineListItem({
    Key? key,
    required this.medicineName,
    required this.salesCount,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                "$position",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          
          SizedBox(width: 12),
          
          // Medicine Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicineName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Sales: $salesCount units",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
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
            child: Text(
              "$salesCount",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: _getPositionColor(position),
              ),
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
}
