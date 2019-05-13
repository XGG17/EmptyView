
# EmptyView（简单的加载页面及空状态页面）

一句代码支持Loading动画、空状态动画、空状态静态图片显示, EmptyView依赖于第三方库：Masonry、lottie-ios、YLGIFImage.

# 使用方法
1、pod方法导入：pod 'EmptyView', :git => 'https://github.com/XGG17/EmptyView.git'

* pod方法导入完成后会同时引入Masonry、lottie-ios、YLGIFImage等依赖的第三方库，请注意避免冲突。


2、在需要的地方引入UIView+emptyView.h文件

3、调用方法
```
/** 系统加载指示器 */
[self.view showNormalLoading:^(EmptyProperty *p) {

}];
```
```
/** 加载Lottie动画 */
[self.view showLottieAnimation:^(EmptyProperty *p) {
    p.imageFile = @"lottie_loading_animation.json";
    p.imageWidth = 150;
    p.showText = @"lottie动画加载中...";
}];
```
```
/** 加载Gif动画 */
[self.view showGifAnimation:^(EmptyProperty *p) {
    p.imageFile = @"gif_animation.gif";
    p.imageWidth = 100;
    p.showText = @"随便写点什么描述~";
    p.btnImageFile = @"btn_image";
}];
```
```
/** 静态空状态页 */
[self.view showEmptyImageView:^(EmptyProperty *p) {
    p.imageFile = @"empty_img";
    p.showText = @"随便写点什么描述~";
}];
```
```
/** 清除空状态页 */
[self.view clearEmptyView];
```

4、点击事件回调
```
self.view.emptyViewClick = ^{
    // do something ...
};
```

