//
//  ViewController.m
//  DCEmptyViewDemo
//
//  Created by dianchou on 2019/5/13.
//  Copyright © 2019 dianchou. All rights reserved.
//

#import "ViewController.h"
#import <UIView+emptyView.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 空白页点击事件
    __weak typeof(self) weakSelf = self;
    self.view.emptyViewClick = ^{
        [weakSelf clearEmptyView];
    };
}

/**
 * 系统加载指示器
 */
- (IBAction)showActivityIndicatorView:(id)sender {
    _mainView.hidden = YES;
    [self.view showNormalLoading:^(EmptyProperty *p) {}];
}

/**
 * 加载动画
 */
- (IBAction)showLoadingAnimation:(id)sender {
    _mainView.hidden = YES;
    
    // Lottie动画
    [self.view showLottieAnimation:^(EmptyProperty *p) {
        p.topMargin = 50;
        p.imageFile = @"lottie_loading_animation.json";
        p.imageWidth = 150;
        p.showText = @"lottie动画加载中...";
    }];
    
    /*
    // Gif动画
    [self.view showGifAnimation:^(EmptyProperty *p) {
        p.imageFile = @"gif_animation.gif";
        p.imageWidth = 100;
        p.showText = @"Gif动画加载中...";
    }];
     */
}

/**
 * 动态空状态页
 */
- (IBAction)showAnimationEmptyView:(id)sender {
    _mainView.hidden = YES;
    
    /*
    // Lottie动画
    [self.view showLottieAnimation:^(EmptyProperty *p) {
        p.imageFile = @"lottie_error_animation.json";
        p.imageWidth = 200;
        p.showText = @"随便写点什么描述~";
        p.btnImageFile = @"btn_image";
    }];
     */
    
    // Gif动画
    [self.view showGifAnimation:^(EmptyProperty *p) {
        p.imageFile = @"gif_animation.gif";
        p.imageWidth = 100;
        p.showText = @"随便写点什么描述~";
        p.btnImageFile = @"btn_image";
    }];
}


/**
 * 静态空状态页
 */
- (IBAction)showNormalEmptyView:(id)sender {
    _mainView.hidden = YES;
    [self.view showEmptyImageView:^(EmptyProperty *p) {
        p.imageFile = @"empty_img";
        p.showText = @"随便写点什么描述~";
        p.btnText = @"按钮文字";
    }];
}

/**
 * 清除空状态页
 */
- (void)clearEmptyView
{
    _mainView.hidden = NO;
    [self.view clearEmptyView];
}

@end
