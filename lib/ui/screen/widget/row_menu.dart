import 'package:flutter/material.dart';

class RowMenu extends StatelessWidget {
  final String title;
  final String description;
  final ImageProvider? image;
  final VoidCallback? onTap;

  const RowMenu({
    Key? key,
    required this.title,
    required this.description,
    this.image,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: image != null
              ? CircleAvatar(
            backgroundImage: image,
            radius: 24.0,
          )
              : null,
          title: Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            description,
            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16.0,
          ),
          onTap: onTap
        ),
      ),
    );
  }
}
