import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DrawerType {
  none,
  product,
  category,
}

final drawerController = StateProvider<DrawerType>((ref) => DrawerType.none);
