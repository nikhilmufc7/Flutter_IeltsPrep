import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  const BaseWidget({
    Key key,
    this.builder,
    @required this.bloc,
    this.child,
    this.onBlocReady,
  }) : super(key: key);

  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T bloc;
  final Widget child;
  final Function(T) onBlocReady;

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T bloc;

  @override
  void initState() {
    bloc = widget.bloc;
    if (widget.onBlocReady != null) {
      widget.onBlocReady(bloc);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => bloc,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
