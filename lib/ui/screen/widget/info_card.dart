

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String name;
  final String hanja;
  final String date;
  final String time;
  final Color color;


  const InfoCard({
    super.key,
    required this.name,
    required this.hanja,
    required this.date,
    required this.time,
    this.color = Colors.white
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: color,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('이름', name),
                SizedBox(height: 8),
                _buildInfoRow('한자', hanja),
                SizedBox(height: 8),
                _buildInfoRow('생년월일', date),
                SizedBox(height: 8),
                _buildInfoRow('출생 시간', time),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}