import 'package:flutter/material.dart';

import 'package:maps_app/models/models.dart';

class PlaceTile extends StatelessWidget {
  final Feature place;
  final IconData icon;
  final VoidCallback onTap;

  const PlaceTile(
      {Key? key,
      required this.place,
      required this.onTap,
      this.icon = Icons.settings_backup_restore_rounded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(place.text),
        subtitle: Text(place.placeName),
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        minLeadingWidth: 10,
        onTap: onTap);
  }
}
