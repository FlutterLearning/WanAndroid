import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MultiProvider2<T extends ChangeNotifier, P extends ChangeNotifier> extends StatefulWidget {
  final T model1;
  final P model2;
  final Widget Function(BuildContext context, T modelT, P modelP, Widget child) builder;
  final Widget child;

  final void Function(T modelT, P modelP) onModelInit;

  const MultiProvider2({Key key, @required this.model1, @required this.model2, @required this.builder, this.child, this.onModelInit})
      : super(key: key);

  @override
  _MultiProvider2State<T, P> createState() {
    return _MultiProvider2State<T, P>();
  }
}

class _MultiProvider2State<T extends ChangeNotifier, P extends ChangeNotifier> extends State<MultiProvider2<T, P>> {
  T model1;
  P model2;

  @override
  void initState() {
    super.initState();
    model1 = widget.model1;
    model2 = widget.model2;
    if(widget.onModelInit != null){
      widget.onModelInit(model1, model2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<T>(builder: (context) => model1),
          ChangeNotifierProvider<P>(builder: (context) => model2),
        ],
        child: Consumer2<T, P>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
