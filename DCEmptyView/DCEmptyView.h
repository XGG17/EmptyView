//
//  DCEmptyView.h
//  DCEmptyViewDemo
//
//  Created by dianchou on 2019/5/12.
//  Copyright © 2019 dianchou. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 相对375屏幕尺寸宽度 */
#define SET_WIDTH(WIDTH) WIDTH /375.0 * [[UIScreen mainScreen] bounds].size.width

/** 设置十六进制颜色 */
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

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

/** 空白页枚举类型 */
@property (nonatomic, assign) DCEmptyType emptyType;
/** 设置空白页属性 */
@property (nonatomic, strong) EmptyProperty *p;

/** 点击事件回调 */
@property (nonatomic, copy) void (^emptyViewClickAction)(void); // 点击空白页回调事件

@end




@interface EmptyProperty : NSObject
/**
 * EmptyProperty 设置空白页属性
 *
 * imageFile : 需要显示的资源文件（图片、lottie、gif等文件名）
 * text : 提示的文字, 默认显示“  加载中... ”, 传@""或nil不显示
 * btnText : 按钮的文字， @""或nil不显示, (默认不显示)
 * btnImageFile : 按钮图片，可以与btnText并存，@""或nil不显示, (默认不显示)
 * topMargin : 距离顶部的距离，默认居中* mageWidth: 设置图片宽度，默认自适应宽度
 * imageWidth: 设置图片宽度，默认自适应宽度
 */
@property (nonatomic,copy) NSString *imageFile;
@property (nonatomic,copy) NSString *showText;
@property (nonatomic,copy) NSString *btnText;
@property (nonatomic,copy) NSString *btnImageFile;
@property (nonatomic,assign) CGFloat topMargin;
@property (nonatomic,assign) CGFloat imageWidth;

@end
