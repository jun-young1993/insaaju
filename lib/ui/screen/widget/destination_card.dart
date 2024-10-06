import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatefulWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const DestinationCard({
    super.key,
    this.crossAxisAlignment  = CrossAxisAlignment.start,
    required this.child,
    this.title, this.actions
  });

  @override
  _DestinationCardSate createState() => _DestinationCardSate();
}

class _DestinationCardSate extends State<DestinationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
          color: Colors.white.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: widget.crossAxisAlignment,
              children: [
                (widget.actions == null)
                ? _buildTitle()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTitle(),
                    Row(
                      children: widget.actions!,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                    child: widget.child
                ),

              ],
            ),
          )
      ),
    );
  }

  Widget _buildTitle(){
    return Text(
      widget.title ?? '',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

}