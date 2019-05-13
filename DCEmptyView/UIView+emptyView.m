//
//  UIView+emptyView.m
//  DCEmptyViewDemo
//
//  Created by dianchou on 2019/5/12.
//  Copyright © 2019 dianchou. All rights reserved.
//

#import "UIView+emptyView.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@implementation UIView (emptyView)

#pragma make - 设置属性(emptyView , emptyViewClick) setter getter
- (void)setEmptyView:(DCEmptyView *)emptyView {
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (DCEmptyView *)emptyView {
    return objc_getAssociatedObject(self, @selector(emptyView));
}

- (void)setEmptyViewClick:(void (^)(void))emptyViewClick {
     objc_setAssociatedObject(self, @selector(emptyViewClick), emptyViewClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(void))emptyViewClick {
    return objc_getAssociatedObject(self, @selector(emptyViewClick));
}


#pragma make - 空白页类型
/**
 * 系统加载指示器
 */
- (void)showNormalLoading:(void (NS_NOESCAPE ^)(EmptyProperty *p))block;
{
    EmptyProperty *p = [EmptyProperty new];
    p.showText = @"  加载中...";
    if (block) {
        block(p);
    }
    [self showEmptyType:DCEmptyTypeNormalLoading property:p];
}

/**
 * 显示lottie动画
 */
- (void)showLottieAnimation:(void (NS_NOESCAPE ^)(EmptyProperty *p))block
{
    EmptyProperty *p = [EmptyProperty new];
    if (block) {
        block(p);
    }
    [self showEmptyType:DCEmptyTypeLottieAnimation property:p];
}

/**
 * 显示Gif动画
 */
- (void)showGifAnimation:(void (NS_NOESCAPE ^)(EmptyProperty *p))block
{
    EmptyProperty *p = [EmptyProperty new];
    if (block) {
        block(p);
    }
    [self showEmptyType:DCEmptyTypeGifAnimation property:p];
}

/**
 * 显示静态图片
 */
- (void)showEmptyImageView:(void (NS_NOESCAPE ^)(EmptyProperty *p))block
{
    EmptyProperty *p = [EmptyProperty new];
    p.showText = @"暂无数据";
    if (block) {
        block(p);
    }
    [self showEmptyType:DCEmptyTypeNormalEmptyView property:p];
}


#pragma make - 清除空白页内容
/** 清除空白页内容 */
- (void)clearEmptyView
{
    self.emptyView.emptyType = DCEmptyTypeDefault;
    [self.emptyView removeFromSuperview];
    self.emptyView = nil;
}



#pragma make - 设置空白页属性
/** 设置空白页属性 */
- (void)showEmptyType:(DCEmptyType)emptyType property:(EmptyProperty *)p
{
    [self clearEmptyView];
    
    self.emptyView = [DCEmptyView new];
    
    __weak typeof(self) weakSelf = self;
    self.emptyView.emptyViewClickAction = ^{
        if (weakSelf.emptyViewClick) {
            weakSelf.emptyViewClick();
        }
    };
    
    [self addSubview:self.emptyView];
    
    if (p.topMargin > 0) {
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(CGRectGetWidth(self.emptyView.superview.bounds) - 24));
            make.centerX.mas_equalTo(self.emptyView.superview);
            make.top.mas_equalTo(p.topMargin);
        }];
    } else {
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.emptyView.superview);
            make.width.mas_equalTo(@(CGRectGetWidth(self.emptyView.superview.bounds) - 24));
        }];
    }
    self.emptyView.emptyType = emptyType;
    self.emptyView.p = p;
}
@end

