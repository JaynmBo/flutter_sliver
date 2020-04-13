@[TOC](SliverAppbar )
NestedScrollView属于Sliver系列控件，是对CustomScrollView的封装。内部由多个controller控制器实现，与RefreshIndicator组合实现ListView下拉刷新时出现滑动BUG。

> 看完本篇文章，相信对于Flutter初学者有一定帮助。


**DEMO地址：[点击下载](https://github.com/jaynm888/flutter_sliver)**

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200413153835885.gif#pic_center)
# 一、SliverAppbar 控件介绍
SliverAppBar “应用栏” 相当于升级版的 appbar 于 AppBar 位置的固定的应用最上面的; 而 SliverAppBar 是可以跟随内容滚动的;
## 1、使用方法
 1. 与CustomScrollView、NestedScrollView集成的材质设计应用栏。应用栏由工具栏和其他小部件组成，例如 TabBar和FlexibleSpaceBar。应用栏通常会使用IconButton公开一个或多个常见操作，后者可选地后跟 PopupMenuButton以进行不太常见的操作
 2. 注意点：
通常结合 CustomScrollView 、 NestedScrollView 来使用它, NestedScrollView里面可以嵌套Listview 完成滑动

## 2、基本属性

```java
const SliverAppBar({
    Key key,
    this.leading,         //在标题左侧显示的一个控件，在首页通常显示应用的 logo；在其他界面通常显示为返回按钮
    this.automaticallyImplyLeading = true,//? 控制是否应该尝试暗示前导小部件为null
    this.title,               //当前界面的标题文字
    this.actions,          //一个 Widget 列表，代表 Toolbar 中所显示的菜单，对于常用的菜单，通常使用 IconButton 来表示；对于不常用的菜单通常使用 PopupMenuButton 来显示为三个点，点击后弹出二级菜单
    this.flexibleSpace,        //一个显示在 AppBar 下方的控件，高度和 AppBar 高度一样， // 可以实现一些特殊的效果，该属性通常在 SliverAppBar 中使用
    this.bottom,         //一个 AppBarBottomWidget 对象，通常是 TabBar。用来在 Toolbar 标题下面显示一个 Tab 导航栏
    this.elevation,            //阴影
    this.forceElevated = false, 
    this.backgroundColor,       //APP bar 的颜色，默认值为 ThemeData.primaryColor。改值通常和下面的三个属性一起使用
    this.brightness,   //App bar 的亮度，有白色和黑色两种主题，默认值为 ThemeData.primaryColorBrightness
    this.iconTheme,  //App bar 上图标的颜色、透明度、和尺寸信息。默认值为 ThemeData().primaryIconTheme
    this.textTheme,    //App bar 上的文字主题。默认值为 ThemeData（）.primaryTextTheme
    this.primary = true,  //此应用栏是否显示在屏幕顶部
    this.centerTitle,     //标题是否居中显示，默认值根据不同的操作系统，显示方式不一样,true居中 false居左
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,//横轴上标题内容 周围的间距
    this.expandedHeight,     //展开高度
    this.floating = false,       //是否随着滑动隐藏标题
    this.pinned = false,  //是否固定在顶部
    this.snap = false,   //与floating结合使用
  })
```

## 3、常用属性
1.  在标题前面显示的一个控件，在首页通常显示应用的logo；在其他界面通常显示为返回按钮。

```java
leading: Icon(_selectedChoice.icon) ,
```

2.  控制是否应该尝试暗示前导小部件为null（如果有 leading 这个不会管用 ,相当于忽略这个参数 ； 如果没有leading ，当有侧边栏的时候， false：不会显示默认的图片，true 会显示 默认图片，并响应打开侧边栏的事件）

```java
automaticallyImplyLeading:true,
```

3. 当前界面的标题文字

```java
 title: Text(_selectedChoice.title )
```

4. 一个 Widget 列表，代表 Toolbar 中所显示的菜单，对于常用的菜单，通常使用 IconButton 来表示；对于不常用的菜单通常使用 PopupMenuButton 来显示为三个点，点击后弹出二级菜单

```java
actions: <Widget>[
     new IconButton( // action button
         icon: new Icon(choices[0].icon),
         onPressed: () { _select(choices[0]); },
     ),
     new IconButton( // action button
         icon: new Icon(choices[1].icon),
         onPressed: () { _select(choices[1]); },
     ),
     new PopupMenuButton<Choice>( // overflow menu
         onSelected: _select,
         itemBuilder: (BuildContext context) {
            return choices.skip(2).map((Choice choice) {
               return new PopupMenuItem<Choice>(
                  value: choice,
                  child: new Text(choice.title),
               );
            }).toList();
         },
      )
   ],
```

5.  一个显示在 AppBar 下方的控件，高度和 AppBar 高度一样，可以实现一些特殊的效果，该属性通常在 SliverAppBar 中使用

```java
flexibleSpace: Container(
  color: Colors.blue,
  width: MediaQuery.of(context).size.width,
  child: Text("aaaaaaaaaa"),
    height: 10,
      )
```

6.  一个 AppBarBottomWidget 对象，通常是 TabBar。用来在 Toolbar 标题下面显示一个 Tab 导航栏

```java
bottom: new TabBar(
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return new Tab(
                text: choice.title,
                icon: new Icon(choice.icon),
              );
            }).toList(),
          )
```
7. 标题居中显示

```java
centerTitle: true,
```

9. 此应用栏是否显示在屏幕顶部

```java
primary: true,
```

 
11. appbar是否随着滑动隐藏标题

```java
 floating: true,
```

12. tab 是否固定在顶部（为true是固定，为false是不固定）

```java
pinned: true,
```

14. 与floating结合使用,如果snap和floating为true，则浮动应用栏将“捕捉”到视图中 

```java
snap: true,
```

16. 可滚动视图的高度（默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度）

```java
expandedHeight: 200.0, 
```
# 二、NestedScrollView控件介绍

可以在其内部嵌套其他滚动视图的滚动视图，其滚动位置是固有链接的。
## 1、使用方法

- 此窗口小部件最常见的用例是可滚动视图，该视图具有一个灵活的SliverAppBar（在标头中包含TabBar）（由 headerSliv​​erBuilder构建，并且在主体中具有TabBarView），以便可滚动视图的内容根据可见的选项卡而有所不同。
- NestedScrollView通过为外部ScrollView和内部ScrollView（位于TabBarView内部的ScrollController）提供自定义ScrollController，从而将它们钩在一起，以便它们作为一个连贯的滚动视图显示给用户，从而解决了此问题 。
## 2、构造方法

```java
const NestedScrollView({
    Key key,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    @required this.headerSliverBuilder,
    @required this.body,
    this.dragStartBehavior = DragStartBehavior.start,
  }) : assert(scrollDirection != null),
       assert(reverse != null),
       assert(headerSliverBuilder != null),
       assert(body != null),
       super(key: key);
```

## 3、与NestedScrollView集成SliverAppBar

```java
@override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: _headerSliverBuilder,
              body : TabBarView(
                children: choices.map((Choice choice) {
                  return new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new ChoiceCard(choice: choice),
                  );
                }).toList(),
              ),
            )
        )
    );
  }
```
# 三、RefreshIndicator与NestedScrollView滑动列表冲突同步解决

RefreshIndicator与NestedScrollView组合下拉刷新是开发过程中常见的一种效果，但是由于NestedScrollView源码中有有内外两个controller控制器。（out控制header，inner控制body。只有当out不能滚动了才会滚动inner）

**与RefreshIndicator组合使用时，下拉刷新效果失效。**

- 首先，我调试到这个，发现notification.depth不为0，其实也好理解，因为NestedScrollView里面有很多能滚动的东西。默认的RefreshIndicator要求的是必须是第一层的它才其效果。

```java
bool defaultScrollNotificationPredicate(ScrollNotification notification) {
  return notification.depth == 0;
}
```


- 其次，我调试到_handleScrollNotification方法中，我们可以看到会有很多ScrollNotification进来，不同的，当你滑动在一个不能滚动的list里面的时候，获取的viewportDimension是为0.。这会覆盖掉之前有viewportDimension的值。


```java
  //定义变量接收临时值
  double tempHeight = 0;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!widget.notificationPredicate(notification)) return false;
    if (notification is ScrollStartNotification &&
        notification.metrics.extentBefore == 0.0 &&
        _mode == null &&
        _start(notification.metrics.axisDirection)) {
      setState(() {
        _mode = _RefreshIndicatorMode.drag;
      });
      return false;
    }

    bool indicatorAtTopNow;

    switch (notification.metrics.axisDirection) {
      case AxisDirection.down:
        indicatorAtTopNow = true;
        break;
      case AxisDirection.up:
        indicatorAtTopNow = false;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        indicatorAtTopNow = null;
        break;
    }
	// 当notification.metrics.viewportDimension时，
	// tempHeight 赋值notification.metrics.viewportDimension
    if (notification.metrics.viewportDimension > 0) {
      tempHeight = notification.metrics.viewportDimension;
    }

    if (indicatorAtTopNow != _isIndicatorAtTop) {
      if (_mode == _RefreshIndicatorMode.drag ||
          _mode == _RefreshIndicatorMode.armed)
        _dismiss(_RefreshIndicatorMode.canceled);
    } else if (notification is ScrollUpdateNotification) {
      if (_mode == _RefreshIndicatorMode.drag ||
          _mode == _RefreshIndicatorMode.armed) {
        if (notification.metrics.extentBefore > 0.0) {
          _dismiss(_RefreshIndicatorMode.canceled);
        } else {
          _dragOffset -= notification.scrollDelta;

          print(tempHeight);
          _checkDragOffset(tempHeight);
        }
      }
      if (_mode == _RefreshIndicatorMode.armed &&
          notification.dragDetails == null) {
        // On iOS start the refresh when the Scrollable bounces back from the
        // overscroll (ScrollNotification indicating this don't have dragDetails
        // because the scroll activity is not directly triggered by a drag).
        _show();
      }
    } else if (notification is OverscrollNotification) {
      if (_mode == _RefreshIndicatorMode.drag ||
          _mode == _RefreshIndicatorMode.armed) {
        _dragOffset -= notification.overscroll / 2.0;
        _checkDragOffset(tempHeight);
      }
    } else if (notification is ScrollEndNotification) {
      switch (_mode) {
        case _RefreshIndicatorMode.armed:
          _show();
          break;
        case _RefreshIndicatorMode.drag:
          _dismiss(_RefreshIndicatorMode.canceled);
          break;
        default:
          // do nothing
          break;
      }
    }
    return false;
  }
```
- 最后在使用RefreshIndicator时，添加notificationPredicate属性
```java
RefreshIndicator(
     notificationPredicate: (notifation) {
     // 返回true即可
       return true;
     },
     onRefresh: () {
       return Future.delayed(Duration(seconds: 2), () {
         return true;
       });
     },
```