import 'package:flutter/material.dart';
import 'package:rgutils/widget_life/widget_visibility_state.dart';

main() {
  runApp(TestPageOnShowApp());
}

class TestPageOnShowApp extends StatelessWidget {
  const TestPageOnShowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (_) => HomePage(),
        "/child": (_) => ChildPage(),
      },
      // home: HomePage(),
      initialRoute: '/',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetVisibilityStateMixin, WidgetsBindingObserver {
  final inputFocus = FocusNode();

  @override
  onHide() {
    super.onHide();
    print('隐藏');
  }

  @override
  void onShow() {
    super.onShow();
    print('显示');
  }

  @override
  void initState() {
    super.initState();
    ignoreFocusList = [inputFocus];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: [
          ...List.generate(
              20,
              (index) => ListTile(
                    title: Text("childPage"),
                    onTap: () {
                      Navigator.pushNamed(context, '/child');
                    },
                  )),

          ///输入框需要单独处理焦点，及时释放，以免影响页面层级焦点的获取
          TextField(
            focusNode: inputFocus,
          ),
          TextButton(
            onPressed: () {
              inputFocus.unfocus();
            },
            child: Text('释放焦点测试'),
          )
        ],
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("childPage"),
      ),
      body: Center(
        child: Text(
          "childPage",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
