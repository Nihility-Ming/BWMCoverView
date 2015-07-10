# BWMCoverView

BWMCoverView是一个非常容易使用的广告轮播视图，支持循环滚动、异步加载图片等功能、动画切换，自定义度也非常高。😄

######效果图：
![BWMCoverView](AppScreenShotCase.gif " BWMCoverView")

![BWMCoverView](AppScreenShot_01.gif " BWMCoverView")

![BWMCoverView](AppScreenShot_02.gif " BWMCoverView")

## 使用方法

使用方法也是非常简单，只需要3步。

> 1. 构建`BWMCoverViewModel`的数组
> 
> 2. 使用`BWMCoverView`的工厂方法`+ coverViewWithModels:andFrame:andPlaceholderImageNamed:andClickdCallBlock:`传递必须要的参数
> 
> 3. 添加`BWMCoverView`到指定视图

### 1.构建一个包含BWMCoverViewModel的数组

```objc
// 此数组用来保存BWMCoverViewModel
NSMutableArray *realArray = [[NSMutableArray alloc] init];

for (int i = 0; i<5; i++) {
    NSString *imageStr = [NSString stringWithFormat:@"http://www.iphone567.com/wp-content/uploads/2014/10/image0%d.jpg", i+1];
    NSString *imageTitle = [NSString stringWithFormat:@"第%d个小猫", i+1];
    BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:imageTitle];
    [realArray addObject:model];
}

// 以上代码只为了构建一个包含BWMCoverViewModel的数组而已——realArray
```
### 2.快速创建BWMCoverView

使用`BWMCoverView`的工厂方法`+ coverViewWithModels:andFrame:andPlaceholderImageNamed:andClickdCallBlock:`传递必须要的参数快速创建BWMCoverView。

参数如下：
* models是一个包含BWMCoverViewModel的数组
* placeholderImageNamed为图片加载前的本地占位图片名
* andClickdCallBlock是点击图片回调的块

```objc
BWMCoverView *coverView = [BWMCoverView coverViewWithModels:realArray andFrame:self.view.frame andPlaceholderImageNamed:BWMCoverViewDefaultImage andClickdCallBlock:^(NSInteger index) {
    NSLog(@"你点击了第%d个图片", index);
}];
```

### 3.添加到指定视图

```objc
[self.view addSubview:coverView];
```

实际上，只需以上3句即可创建BWMCoverView了，也可以继续往下看，自定义更多效果

#### 更多创建方法

例子：

```objc
// 你也可以试着调用init方法创建BWMCoverView
BWMCoverView *coverView2 = [[BWMCoverView alloc] initWithFrame:self.view.frame];
[self.view addSubview:coverView2];

coverView2.models = realArray;
coverView2.placeholderImageNamed = BWMCoverViewDefaultImage;
coverView2.animationOption = UIViewAnimationOptionTransitionCurlUp;

[coverView2 setCallBlock:^(NSInteger index) {
    NSLog(@"你点击了第%d个图片", index);
}];

[coverView2 setScrollViewCallBlock:^(NSInteger index) {
    NSLog(@"当前滚动到第%d个页面", index);
}];
```

### 自定义功能选项

#### 可选1：设置视图每一次滚动都会回调的方法

```objc
[coverView setScrollViewCallBlock:^(NSInteger index) {
    NSLog(@"当前滚动到第%d个页面", index);
}];
```

#### 可选2：设置自动播放

```objc
[coverView setAutoPlayWithDelay:3.0]; 
```

其中`3.0`是间距秒数。

#### 可选3：设置图片显示内容模式

```objc
coverView.imageViewsContentMode = UIViewContentModeScaleAspectFit;
```

支持iOS `UIKit`自带的`enum` `UIViewContentMode`

#### 可选4：停止/恢复自动播放

```objc
[coverView stopAutoPlayWithBOOL:YES]; // 停止自动播放
[coverView stopAutoPlayWithBOOL:NO]; // 恢复自动播放
```

#### 可选5：设置切换动画

```objc
[coverView setAnimationOption:UIViewAnimationOptionTransitionCurlUp]; // 设置切换动画
```

#### 可选6：设置隐藏TitleLabel

```objc
coverView.titleLabel.hidden = YES; //隐藏TitleLabel
```

##### 主要有以下UI成员：
> * coverView2.scrollView
> * coverView2.pageControl
> * coverView2.titleLabel

详情请查看接口文件`BWMCoverView.h`。

####  修改属性后必须调用updateView方法

```objc
[coverView updateView]; //修改属性后必须调用updateView方法，更新视图
```

## 安装方法

* 直接把BWMCoverView Drag到您的工程
* 使用CocoaPods 来 pod "BWMCoverView"

## 协议

BWMCoverView遵循 MIT 协议. 详情请查看
[LICENSE.md](LICENSE.md).

## 联系我

有任何问题或建议，请联系我的QQ724849296  📱15918550637。