import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); //流状态的文件，flutter把app看做有限状态自动机所以
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); //超验构造函数

  // This widget is the root of your application.
  @override //覆盖函数
  Widget build(BuildContext context) {
    return MaterialApp(
      //materialapp是个ui设计规范 ，例如开始菜单在右下角巴拉巴拉
      //一条长语句（一整个构造函数）
      title: 'Flutter Demo', //参数名称和值
      theme: ThemeData(
        //参数名称和值

        primarySwatch: Colors.blue,
      ),
     //  home: const MyHomePage(title: 'Flutter Demo Home Page'), //计数器程序扩展、基础组件、动画
      home:   SingleChildScrollViewTestRoute(),//滚动条
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); //胖箭头创立函数
}



class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    //方法
    setState(/*以下内容为一个匿名函数功能是count++*/ () {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //一个覆盖方法

    return Scaffold(
      //很长的return语句
      appBar: AppBar(
        //第一个参数值为appbar

        title: Text(widget.title),
      ),
      body: Center(
        //body的值是center但center又是一个对象有构造函数什么的

        child: Column(
           
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[//children里有个列表<widget>
            
           
            const Text(
              '诶嘿:',
            ),
            Text(
              '一起来玩吧',
              // style: Theme.of(context).textTheme.headline4,//显示多少次
            ),
            TextButton(
              child: Text("吨吨吨"),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              color: Colors.red,
              onPressed: () {},
            ),
            /*Image.network(
  "https://i0.hdslb.com/bfs/new_dyn/7d0edd2d12cb83535fe8554b5ce41d2e27626322.jpg@560w_560h_1e_1c.webp",
  width: 100.0,
            )， */
             ScaleAnimationRoute(//图片逐渐变大
   imageUrl: "https://i0.hdslb.com/bfs/new_dyn/7d0edd2d12cb83535fe8554b5ce41d2e27626322.jpg@560w_560h_1e_1c.webp",
            ),
          
          ],
        ),
      ),
     
      floatingActionButton: FloatingActionButton(
        //放置一个浮动按钮
        onPressed: _incrementCounter, //点击增加次数，函数在上面
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}


class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar( // 显示进度条
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column( 
            //动态创建一个List<Widget>  
            children: str.split("") 
                //每一个字母都用一个Text显示,字体为原来的两倍
                .map((c) => Text(c, textScaleFactor: 2.0,)) 
                .toList(),
          ),
        ),
      ),
    );
  }
}




class ThemeTestRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  var _themeColor = Colors.teal; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themeColor) //用于Icon颜色
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色跟随主题")
                ]
            ),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(
                    color: Colors.black
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色")
                  ]
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>  //切换主题
                setState(() =>
                _themeColor =
                _themeColor == Colors.teal ? Colors.blue : Colors.teal
                ),
            child: Icon(Icons.palette)
        ),
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  
  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    //匀速
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() => {});
      });

    //启动动画(正向执行)
     controller.forward();
  }

  @override
@override
Widget build(BuildContext context) {
  return Center(
    child: Image.network(
     widget.imageUrl,
      width: animation.value,
      height: animation.value,
    ),
  );
}
  
  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}