# CEThemeSwitcher
本篇博客就来介绍一下iOS App中主题切换的常规做法，当然本篇博客中只是提到了一种主题切换的方法，当然还有其他方法，在此就不做过多赘述了。本篇博客中所涉及的Demo完全使用Swift3.0编写完成，并使用iOS的NSNotification来触发主题切换的动作。本篇博客我们先对我们的主题系统进行设计，然后给出具体实现方式。当然在我们设计本篇博客所涉及的Demo时，我们要遵循“高内聚，低耦合”，“面向接口编程”，“便于维护与扩充”等特点。

本篇博客我们先看一下Demo的运行效果，然后给出设计方案已经对应的类图，然后再根据设计的类图给出相应的代码实现。

## 一、主题切换效果展示

先入为主，接下来我们先看一下本篇博客所涉及Demo的最终运行效果。为了看到整体主题切换的效果，所以我们添加了一个主页以及主页Push进去的子页面。另一个页面就是选择相应主题的页面，也就是下方你所看到的TabieView的列表页，该列表中提供了6种可选的主题，点击相应的主题即可切换到该主题上。

当然主题切换，意味着整个App的风格都得改变，所以当修改完主题后，主页以及其子页面的主题也得随之改变。具体效果如下gif图所示。当然Demo比较简单，但是麻雀虽小，五脏俱全，用来了解App的主题切换足以。当然有更好的实现方式，欢迎留言交流。
![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116163059771-1752866994.gif)

## 二、设计主题切换功能的整体结构

看完效果后，接下来我们就进入了设计阶段。根据上述Demo的特点，我们先给出相应的类图，当然我们敲代码时要根据该类图进行实现。下方截图就是我们本篇博客主题切换工程的类图了。该类图中省略了一些细节，给出了核心的内容。接下来我们来详细的看一下下方这个类图的结构，如果下方的类图搞明白了，那么在下部分中看相应代码时，就会显得游刃有余了，因为我们的代码是按照下方的类图所实现的。只不过比下方类图更为详细。

接下来我们就来看一下类图的结构，我们就按照不同颜色的框逐一介绍，框中的内容算是一个模块。

* 红色框：下方类图红色框中就是我们的主题协议ThemeProtocol以及遵循该协议的所有主题。当然，依据“面向接口”编程的规则，外部所依赖的不是所有的主题类，而是主题协议ThemeProtocol。也就是ThemeManager类依赖于ThemeProtocol。而所有的主题类通过工厂类或者工厂方法间接的与ThemeManager。因为鉴于Swift中的枚举中可以添加相应的计算属性以及方法，所以我们可以使用相应的主题枚举来充当这个工厂类，当然下方类图中没有给出，这个要看具体的代码实现。

* 蓝色框：接下来我们就来看蓝色框，蓝色框中的SuperLabelClass是所有可以改变主题的Label的父类，也就是说在改变主题时，需要改变相应的Label就要继承该类。

* 黑色框：该框中中则是SuperViewController及其子类，需要更换主题的VC都要继承自该基类。

* 绿色框：绿框中则负责修改主题，其中根据Cell的类型来确定用户选择的是哪个主题。

* ThemeManager: 该类以单例的形式存在，负责管理相应的主题，切换主题时，直接调用ThemeManager中的相应的方法即可。

上面只是简单的介绍一下类图，具体的还要看代码的实现。

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116153214755-814451335.png)

## 三、主题以及主题管理者的实现

看完运行效果以及设计类图，接下来我们就来一下具体的代码实现本部分我们就来看一下相应的主题类以及主题管理者的代码实现。下方会先给出主题协议以及各个主题类的实现，然后再给出主题工厂方法以及主题管理者的实现。 

### 1、主题协议的实现

下方就是我们定义的主题协议，所有主题都要遵循该协议。因为本篇博客的Demo在切换主题时只涉及到了三个元素，一个是背景色（backgroundColor），一个是标题的颜色（titleTextColor），在一个就是详情的颜色（detailTextColor）。所以在我们的主题协议中有三个只读的计算属性与之对应。具体如下所示：

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116171231177-108662796.png)

### 2.各个主题的实现

接下来我们就要看看各个主题的实现了，我们就以红色主题（RedTheme）为例。RedTheme要遵循ThemeProtocol，并且实现协议中规定的方法。在RedTheme中每个计算属性都会返回当前主题所对应的属性。具体如下所示。当然其他主题与下方的RedTheme类似，只是每个计算属性返回的值不同。

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116171853927-787849182.png)


上面在返回UIColor对象时，我们用到了UIColor.colorWithHex(十六进制数)。colorWithHex()是我们在UIColor的延展中添加的静态方法，该方法可以根据十六进制的RGB参数来初始化相应的UIColor对象。下方是该UIColor延展中的具体内容。下方代码的核心就是位操作的使用。

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116172445255-1007276779.png)

### 3.简单工厂的创建

主题协议已经主题类构建完毕后，接下来我们就该将这些主题进行打包输出了。 下方的代码段本质上就是主题类的简单工厂，因为Swift的枚举类型有很多好用的特性，所以我们使用了Swift的枚举来实现这些主题的简单工厂。代码结构比较简单，在此就不做过多赘述了。

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116172803411-1038150053.png)

### 4.主题管理者(ThemeManager)的创建
上面关于主题的基本工作已经做完，接下来我们就为这些主题来创建一个主题管理者ThemeManager。ThemeManager会根据用户需求从上面的主题工厂中取出相应的主题对象提供给用户，这也就是ThemeManager的职能所在。

下方就是我们主题管理者ThemeManager的具体实现代码，ThemeManager是以单例的姿态对外展现的。因为主题管理者在整个App运行时只需要一个，所以我们赋予了ThemeManager一个单例的身份与用户进行交流。单例实现完毕后，接着社一些便利方法，这些便利方法都是静态方法，便于用户直接使用。接着是一些ThemeManager的私有方法。

在ThemeManager的私有方法中，switcherTheme(themeType)是关键，该方法在收到修改主题的事件后，会发出修改主题的通知，而通知的内容就是将要进行修改的主题。那些可以修改主题的控件，在收到该通知的消息后，会根据通知内容修改其自身的主题。具体代码如下所示：

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116173619958-984468882.png)

## 四、可更换主题的控件处理

主题以及主题管理者实现完毕，接下来就该使用了。在主题切换时，需要修改属性的控件我们需要进行处理，使其监听主题切换的通知，并根据通知内容修改控件的属性。在本部分我们就以SuperViewController为例。首先我们要将SuperViewController添加为主题切换的观察者，然后实现收到通知后的方法。在析构函数中，切记要移除观察者。具体代码如下所示。

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116174555911-168240809.png)
　　
## 五、调用ThemeManager更换主题

万事俱备只欠东风，接下来我们就要在恰当的地方调用ThemeManager的switcherTheme()的方法进行替换了。当然我们是在我们的Cell来处理的，因为每种cell都对应着主题的类型，下方就是Cell类型的枚举。CellTitleType中的themeType计算属性就对应着相应的主题类型，我们可以将该类型提供给ThemeManager，让后ThemeManager发出更改主题的通知。

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116175353817-300404867.png)

下方就是调用ThemeManager的switcherTheme()方法来更换主题。

![](http://images2015.cnblogs.com/blog/545446/201701/545446-20170116175646114-1524334145.png)

 