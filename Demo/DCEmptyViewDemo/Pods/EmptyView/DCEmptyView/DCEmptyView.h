//
//  DCEmptyView.h
//  DCEmptyViewDemo
//
//  Created by dianchou on 2019/5/12.
//  Copyright © 2019 dianchou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <Lottie/Lottie.h>
#import <YLGIFImage/YLImageView.h>
#import <YLGIFImage/YLGIFImage.h>


/** 空状态枚举 */
typedef NS_ENUM(NSInteger , DCEmptyType){
    DCEmptyTypeDefault,         // 默认不显示状态
    DCEmptyTypeNormalLoading,   // 系统加载指示器动画
    DCEmptyTypeLottieAnimation, // Lottie动画
    DCEmptyTypeGifAnimation,    // gif动画
    DCEmptyTypeNormalEmptyView  // 显示静态空白页
};

@class EmptyProperty;

@interface DCEmptyView : UIView

/**
 * 枚举类型
 */
@property (nonatomic, assign) DCEmptyType emptyType;

/**
 * 设置空状态属性
 */
@property (nonatomic, strong) EmptyProperty *p;

/**
 * 点击事件回调
 */
@property (nonatomic, copy) void (^emptyViewClickAction)(void);
@end


#pragma mark - ======== EmptyProperty 类 =========

@interface EmptyProperty : NSObject
/**
 * EmptyProperty 设置空状态属性
 *
 * imageFile    : 需要显示的资源文件（图片、lottie、gif等文件名，默认不显示)；
 * showText     : 描述文字，传@""或nil不显示(默认不显示)；
 * btnText      : 按钮文字，传@""或nil不显示(默认不显示)；
 * btnImageFile : 按钮图片，传@""或nil不显示(默认不显示)；
 * topMargin    : 距离顶部的距离（>0有效），默认居中；
 * imageWidth   : 设置图片宽度，默认自适应宽度；
 */
@property (nonatomic,copy) NSString *imageFile;
@property (nonatomic,copy) NSString *showText;
@property (nonatomic,copy) NSString *btnText;
@property (nonatomic,copy) NSString *btnImageFile;
@property (nonatomic,assign) CGFloat topMargin;
@property (nonatomic,assign) CGFloat imageWidth;

@end
