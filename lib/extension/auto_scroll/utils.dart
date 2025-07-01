//Copyright (C) 2019 Potix Corporation. All Rights Reserved.
//History: Tue Apr 24 09:17 CST 2019
// Author: Jerry Chen

import "dart:async";
import "dart:collection";

import "package:flutter/animation.dart";

/// used to invoke async functions in order
Future<T> co<T>(key, FutureOr<T> Function() action) async {
  for (;;) {
    final Completer? c = _locks[key];
    if (c == null) break;
    try {
      await c.future;
    } catch (_) {} //ignore error (so it will continue)
  }

  final Completer<T> c = _locks[key] = Completer<T>();
  void then(T result) {
    final Completer? c2 = _locks.remove(key);
    c.complete(result);

    assert(identical(c, c2));
  }

  void catchError(ex, StackTrace st) {
    final Completer? c2 = _locks.remove(key);
    c.completeError(ex, st);

    assert(identical(c, c2));
  }

  try {
    final FutureOr<T> result = action();
    if (result is Future<T>) {
      result.then(then).catchError(catchError);
    } else {
      then(result);
    }
  } catch (ex, st) {
    catchError(ex, st);
  }

  return c.future;
}

final HashMap<dynamic, Completer> _locks = HashMap<dynamic, Completer>();

/// skip the TickerCanceled exception
Future catchAnimationCancel(TickerFuture future) async =>
    future.orCancel.catchError((_) async {
      // do nothing, skip TickerCanceled exception
      return null;
    }, test: (Object ex) => ex is TickerCanceled);
