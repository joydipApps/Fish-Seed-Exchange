import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider = StateProvider<int>((ref) => 0); // Initial filter index

//final fishListFilterProvider = StateProvider<String>((ref) => '');
