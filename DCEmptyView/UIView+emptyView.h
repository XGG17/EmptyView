//
//  UIView+emptyView.h
//  DCEmptyViewDemo
//
//  Created by dianchou on 2019/5/12.
//  Copyright © 2019 dianchou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCEmptyView.h"

@interface UIView (emptyView)

/**
 * 空白页对象
 */
@property (nonatomic, strong) DCEmptyView *emptyView;

/**
 * 空白页点击回调
 */
@property (nonatomic, copy) void (^ emptyViewClick)(void);

/**
 * 系统加载指示器
 */
- (void)showNormalLoading:(void (NS_NOESCAPE ^)(EmptyProperty *p))block;

/**
 * 显示lottie动画
 */
- (void)showLottieAnimation:(void (NS_NOESCAPE ^)(EmptyProperty *p))block;

/**
 * 显示Gif动画
 */
- (void)showGifAnimation:(void (NS_NOESCAPE ^)(EmptyProperty *p))block;

/**
 * 显示静态图片
 */
- (void)showEmptyImageView:(void (NS_NOESCAPE ^)(EmptyProperty *p))block;

/**
 * 清除空白页内容
 */
- (void)clearEmptyView;

@end
