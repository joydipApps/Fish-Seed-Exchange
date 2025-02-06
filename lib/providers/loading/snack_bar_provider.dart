import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/snack_bar_helper.dart';

final snackBarProvider = Provider((ref) => SnackBarHelper());
