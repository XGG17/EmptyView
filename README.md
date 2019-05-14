
# EmptyView（简单的loading页面及空状态页面）

一句代码支持Loading动画、空状态动画、空状态静态图片显示, EmptyView依赖于第三方库：[Masonry](https://github.com/SnapKit/Masonry)、[lottie-ios](https://github.com/airbnb/lottie-ios/tree/lottie/objectiveC)、[YLGIFImage](https://github.com/liyong03/YLGIFImage).

# 使用方法
1、pod方法导入：pod 'EmptyView', :git => 'https://github.com/XGG17/EmptyView.git'

* pod方法导入完成后会同时引入Masonry、lottie-ios、YLGIFImage等依赖的第三方库，请注意避免冲突。


2、在需要的地方引入UIView+emptyView.h文件

3、调用方法
```
/** 系统加载指示器 */
[view showNormalLoading:^(EmptyProperty *p) {

}];
```
```
/** 加载Lottie动画 */
[view showLottieAnimation:^(EmptyProperty *p) {
    p.imageFile = @"lottie_loading_animation.json";
    p.imageWidth = 150;
    p.showText = @"lottie动画加载中...";
}];
```
```
/** 加载Gif动画 */
[view showGifAnimation:^(EmptyProperty *p) {
    p.imageFile = @"gif_animation.gif";
    p.imageWidth = 100;
    p.showText = @"随便写点什么描述~";
    p.btnImageFile = @"btn_image";
}];
```
```
/** 静态空状态页 */
[view showEmptyImageView:^(EmptyProperty *p) {
    p.imageFile = @"empty_img";
    p.showText = @"随便写点什么描述~";
}];
```
```
/** 清除空状态页 */
[view clearEmptyView];
```

4、点击事件回调
```
view.emptyViewClick = ^{
    // do something ...
};
```

5、EmptyProperty类属性释义
```
 imageFile    : 需要显示的资源文件（图片、lottie、gif等文件名，默认不显示)；
 showText     : 描述文字，传@""或nil不显示(默认不显示)；
 btnText      : 按钮文字，传@""或nil不显示(默认不显示)；
 btnImageFile : 按钮图片，传@""或nil不显示(默认不显示)；
 topMargin    : 距离顶部的距离（>0有效），默认居中；
 imageWidth   : 设置图片宽度，默认自适应宽度；
```

