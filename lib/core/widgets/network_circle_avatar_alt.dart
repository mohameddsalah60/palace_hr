import 'dart:async';

import 'package:flutter/material.dart';

class NetworkCircleAvatarAlt extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String fallbackAsset;

  const NetworkCircleAvatarAlt({
    super.key,
    required this.imageUrl,
    this.radius = 30,
    this.fallbackAsset = 'assets/images/palace_logo.png',
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _testImage(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == true) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(imageUrl!),
          );
        } else {
          return CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage(fallbackAsset),
            backgroundColor: Colors.grey[200],
          );
        }
      },
    );
  }

  Future<bool> _testImage(String? url) async {
    if (url == null || url.isEmpty) return false;
    try {
      final image = NetworkImage(url);
      final config = ImageConfiguration();
      final completer = Completer<bool>();
      final stream = image.resolve(config);
      stream.addListener(
        ImageStreamListener(
          (info, _) => completer.complete(true),
          onError: (_, __) => completer.complete(false),
        ),
      );
      return await completer.future.timeout(const Duration(seconds: 2));
    } catch (_) {
      return false;
    }
  }
}
