import 'package:flutter/material.dart';

/// Implementation for [SwitchingFirebaseImage] to expose a
/// disposable build context.
mixin SwitchingFirebaseImageState<T extends StatefulWidget> on State<T> {
  /// [DisposableBuildContext] to allow scroll aware firebase images.
  late DisposableBuildContext<SwitchingFirebaseImageState<T>> scrollAwareContext;

  @override @mustCallSuper
  void initState() {
    scrollAwareContext = DisposableBuildContext<SwitchingFirebaseImageState<T>>(this);
    super.initState();
  }

  @override @mustCallSuper
  void dispose() {
    scrollAwareContext.dispose();
    super.dispose();
  }
}
