

import 'package:flutter/foundation.dart';

class APIBase{
  static String get baseURL {
    if (kReleaseMode) {
      return "https://karnatakajudiciary.kar.nic.in/api/";
    } else {
      return "https://karnatakajudiciary.kar.nic.in/api/";
    }

  }


}