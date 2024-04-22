import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionWidget extends StatefulWidget {
  const VersionWidget({super.key});

  @override
  State<VersionWidget> createState() => _VersionWidgetState();
}

class _VersionWidgetState extends State<VersionWidget> {
  String version = '-';

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      PackageInfo platform = await PackageInfo.fromPlatform();
      setState(() {
        version = platform.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Version: $version',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
