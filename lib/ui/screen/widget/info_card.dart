

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final Color color;


  const InfoCard({
    super.key,
    required this.name,
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
                _buildInfoRow('이름', name, true),
                // SizedBox(height: 8),
                // _buildInfoRow('한자', hanja),
                SizedBox(height: 8),
                _buildInfoRow('생년월일', date, true),
                SizedBox(height: 8),
                _buildInfoRow('출생 시간', time, false),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildInfoRow(String label, String value, bool isDrive) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const labelStyle = TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87, // 레이블 색상
        );
        const valueStyle = TextStyle(
          fontSize: 16,
          color: Colors.black54, // 값의 색상
        );

        if (constraints.maxWidth < 200) {
          // 공간이 좁을 때는 Column 사용
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: labelStyle,
              ),
              const SizedBox(height: 4), // 레이블과 값 사이에 여백 추가
              Text(
                value,
                style: valueStyle,
              ),
              if(isDrive == true)
                const Divider(
                  color: Colors.grey, // 항목 사이에 구분선 추가
                  thickness: 1,
                  height: 20, // 구분선과 항목 사이에 여백 추가
                ),
            ],
          );
        } else {
          // 공간이 충분할 때는 Row 사용
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: labelStyle,
              ),
              const SizedBox(width: 8), // 레이블과 값 사이에 가로 여백 추가
              Expanded(
                child: Text(
                  value,
                  style: valueStyle,
                ),
              ),
              if(isDrive == true)
                const Divider(
                  color: Colors.grey, // 구분선 추가
                  thickness: 1,
                  height: 20, // 구분선과 항목 사이에 여백 추가
                ),
            ],
          );
        }
      },
    );
  }
}