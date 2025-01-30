import 'package:flutter/material.dart';

import '../../model/type/method_type.dart';

enum MethodUiType {
  get(color: Color(0xff98ff98)),
  post(color: Color(0xff00aaff)),
  put(color: Color(0xff00bbff)),
  patch(color: Color(0xff00ccff)),
  delete(color: Color(0xffff6666)),
  head(color: Color(0xffc7ffc7)),
  connect(color: Color(0xffd88aff)),
  options(color: Color(0xffc7c7c7)),
  trace(color: Color(0xffc7c7c7)),
  ;

  const MethodUiType({required this.color});

  final Color color;

  MethodType toMethodType() {
    return MethodType.values.byName(name);
  }
}
