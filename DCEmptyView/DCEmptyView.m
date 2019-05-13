//
//  DCEmptyView.m
//  DCEmptyViewDemo
//
//  Created by dianchou on 2019/5/12.
//  Copyright © 2019 dianchou. All rights reserved.
//

#import "DCEmptyView.h"
#import <Masonry/Masonry.h>
#import <Lottie/Lottie.h>
#import <YLGIFImage/YLImageView.h>
#import <YLGIFImage/YLGIFImage.h>

@interface DCEmptyView()
@property (nonatomic, strong) LOTAnimationView *lottieView;
@property (nonatomic, strong) YLImageView *gifView;
@property (nonatomic, strong) UIActivityIndicatorView *defaultIndicator;
@property (nonatomic, strong) UIImageView *defaultImageView;
@property (nonatomic, strong) UILabel *tipsLab;
@property (nonatomic, strong) UIButton *clickButton;
@property (nonatomic, assign) CGFloat imageHeight;

@end

@implementation DCEmptyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmptyViewAction)]];
    }
    return self;
}


#pragma mark -  ====== Setter方法 设置空白页属性 =====

// 设置空白页状态
- (void)setEmptyType:(DCEmptyType)emptyType
{
    _emptyType = emptyType;
    self.hidden = NO;
    // 显示正常状态
    if (_emptyType == DCEmptyTypeDefault) {
        [self closeEmptyContentView];
    }
    // 系统加载动画
    if (_emptyType == DCEmptyTypeNormalLoading) {
        [self _initDefaultIndicator];
    }
    // lottie加载动画
    if (_emptyType == DCEmptyTypeLottieAnimation) {
        [self _initLottieAnimation];
    }
    // gif加载动画
    if (_emptyType == DCEmptyTypeGifAnimation) {
        [self _initGifAnimation];
    }
    // 静态空白页图片
    if (_emptyType == DCEmptyTypeNormalEmptyView) {
        [self _initNormalEmptyView];
    }
}

- (void)setP:(EmptyProperty *)p
{
    _p = p;
    
    [self setImageFile];
    [self setShowText];
    [self setBtnProperty];
    [self setImageWidth];
}

// 设置内容动画\图片宽（按尺寸自适应高度）
- (void)setImageWidth
{
    if (_defaultIndicator) {
        _p.imageWidth = 50;
        self.imageHeight = 50;
    }
    UIView *animationView = nil;
    if (_defaultImageView) {
        animationView = _defaultImageView;
    }
    if (_lottieView) {
        animationView = _lottieView;
    }
    if (_gifView) {
        animationView = _gifView;
    }
    
    if (_p.imageWidth > 0) {
        [animationView layoutIfNeeded];
        _imageHeight = animationView.frame.size.height * _p.imageWidth / animationView.frame.size.width;
        _imageHeight = isnan(_imageHeight) ? 0 : _imageHeight;
        [self setAnimationSize:animationView];        
    }
}
// 设置动画视图大小
- (void)setAnimationSize:(UIView *)animationView
{
    if (animationView == nil) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [animationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(weakSelf.p.imageWidth));
        make.height.equalTo(@(weakSelf.imageHeight));
    }];
}


// 设置资源文件
- (void)setImageFile
{
    // 设置静态页面
    if (_emptyType == DCEmptyTypeNormalEmptyView) {
        if (_p.imageFile) {
            _defaultImageView.image = [UIImage imageNamed:_p.imageFile];
        }
    }
    
    // 设置Lottie动画
    if (_emptyType == DCEmptyTypeLottieAnimation) {
        if (_p.imageFile) {
            [_lottieView setAnimationNamed:_p.imageFile];
        }
    }
    
    // 设置Gif动画
    if (_emptyType == DCEmptyTypeGifAnimation) {
        if (_p.imageFile) {
            _gifView.image = [YLGIFImage imageNamed:_p.imageFile];
        }
    }
}


// 设置文字提示（@""或nil 则不显示）
- (void)setShowText
{
    _tipsLab.text = _p.showText;
    if (_p.showText == nil || [_p.showText isEqualToString:@""]) {
        [_tipsLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            make.bottom.mas_equalTo(self->_clickButton.mas_top).mas_equalTo(-20);
        }];
        [_gifView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self->_tipsLab.mas_top).mas_equalTo(0);
        }];
    }
}

// 设置点击按钮文案（@""或nil 则不显示）
- (void)setBtnProperty
{
    if (_p.btnText != nil && ![_p.btnText isEqualToString:@""]) {
        [_clickButton setTitle:_p.btnText forState:UIControlStateNormal];
        _clickButton.layer.borderColor = [HEXCOLOR(0xb6b6b6) colorWithAlphaComponent:0.5].CGColor;
        _clickButton.layer.borderWidth = 1;
    } else {
        if (_p.btnImageFile != nil && ![_p.btnImageFile isEqualToString:@""]) {
            UIImage *btnImage = [UIImage imageNamed:_p.btnImageFile];
            [_clickButton setImage:btnImage forState:UIControlStateNormal];
            [_clickButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(btnImage.size.width);
                make.height.mas_equalTo(btnImage.size.height);
            }];
        } else {
            [_clickButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
                make.bottom.mas_equalTo(self).mas_equalTo(0);
            }];
            [_tipsLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self->_clickButton.mas_top).mas_equalTo(0);
            }];
        }
    }
}


#pragma mark - ======= 初始化内容View =======

// 初始化默认加载指示器
- (void)_initDefaultIndicator
{
    [self addSubview:self.defaultIndicator];
    [self addSubview:self.tipsLab];
    [self addSubview:self.clickButton];
    
    [_defaultIndicator startAnimating];
    
    __weak typeof(self) weakSelf = self;
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(SET_WIDTH(30)));
        make.width.mas_equalTo(@(SET_WIDTH(80)));
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
    }];
    [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.bottom.mas_equalTo(weakSelf.clickButton.mas_top).mas_equalTo(-30);
    }];
    [_defaultIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(weakSelf.tipsLab.mas_top).mas_equalTo(-10);
    }];
}

// 初始化空状态图片
- (void)_initNormalEmptyView {
    [self addSubview:self.defaultImageView];
    [self addSubview:self.tipsLab];
    [self addSubview:self.clickButton];
    
    __weak typeof(self) weakSelf = self;
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(SET_WIDTH(30)));
        make.width.mas_equalTo(@(SET_WIDTH(80)));
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
    }];
    [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.bottom.mas_equalTo(weakSelf.clickButton.mas_top).mas_equalTo(-30);
    }];
    [_defaultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(weakSelf.tipsLab.mas_top).mas_equalTo(-10);
    }];
}

// 初始化lottie加载动画
- (void)_initLottieAnimation
{
    [self addSubview:self.lottieView];
    [self addSubview:self.tipsLab];
    [self addSubview:self.clickButton];
    
    [_lottieView play];
    
    __weak typeof(self) weakSelf = self;
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(SET_WIDTH(30)));
        make.width.mas_equalTo(@(SET_WIDTH(80)));
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
    }];
    [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.bottom.mas_equalTo(weakSelf.clickButton.mas_top).mas_equalTo(-30);
    }];
    [_lottieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(weakSelf.tipsLab.mas_top).mas_equalTo(-10);
    }];
}


// 初始化Gif加载动画
- (void)_initGifAnimation
{
    [self addSubview:self.gifView];
    [self addSubview:self.tipsLab];
    [self addSubview:self.clickButton];
    
    __weak typeof(self) weakSelf = self;
    [_clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(SET_WIDTH(30)));
        make.width.mas_equalTo(@(SET_WIDTH(80)));
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
    }];
    [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.bottom.mas_equalTo(weakSelf.clickButton.mas_top).mas_equalTo(-30);
    }];
    [_gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(weakSelf.tipsLab.mas_top).mas_equalTo(-10);
    }];
}


#pragma mark - ======= 关闭加载动画\图片 ========

- (void)closeEmptyContentView
{
    // 移除、关闭所有动画视图
    if (_defaultIndicator.isAnimating) {
        [_defaultIndicator stopAnimating];
    }
    if (_lottieView.isAnimationPlaying) {
        [_lottieView stop];
    }
    if (_gifView.animating) {
        [_gifView stopAnimating];
    }
    while (self.subviews.lastObject != nil) {
        [self.subviews.lastObject removeFromSuperview];
    }
    
    // 回收指针
    _defaultIndicator = nil;
    _defaultImageView = nil;
    _gifView = nil;
    _tipsLab = nil;
    _clickButton = nil;
    _lottieView = nil;
    
    self.hidden = YES;
}


#pragma mark - ======= 点击事件 =======
// view点击回调
- (void)clickEmptyViewAction
{
    if (_emptyViewClickAction) {
        _emptyViewClickAction();
    }
}


#pragma mark -  ====== Getter方法懒加载属性 =====
// 默认加载指示器
- (UIActivityIndicatorView *)defaultIndicator
{
    if (_defaultIndicator == nil) {
        _defaultIndicator = [[UIActivityIndicatorView alloc] init];
        _defaultIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _defaultIndicator.userInteractionEnabled = NO;
    }
    return _defaultIndicator;
}

// 默认图片
- (UIImageView *)defaultImageView
{
    if (_defaultImageView == nil) {
        _defaultImageView = [[UIImageView alloc] init];
        _defaultImageView.contentMode = UIViewContentModeScaleAspectFill;
        _defaultImageView.clipsToBounds = YES;
        _defaultImageView.userInteractionEnabled = NO;
    }
    return _defaultImageView;
}

// lottie显示视图
- (LOTAnimationView *)lottieView
{
    if (_lottieView == nil) {
        _lottieView = [LOTAnimationView new];
        _lottieView.loopAnimation = YES;
        _lottieView.contentMode = UIViewContentModeScaleAspectFill;
        _lottieView.userInteractionEnabled = NO;
    }
    return _lottieView;
}

// GIF显示视图
- (YLImageView *)gifView
{
    if (_gifView == nil) {
        _gifView = [YLImageView new];
        _gifView.userInteractionEnabled = NO;
    }
    return _gifView;
}

// 文字提示视图
- (UILabel *)tipsLab
{
    if (_tipsLab == nil) {
        _tipsLab = [[UILabel alloc] init];
        _tipsLab.font = [UIFont systemFontOfSize:14];
        _tipsLab.numberOfLines = 2;
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        _tipsLab.textColor = HEXCOLOR(0xb6b6b6);
        _tipsLab.userInteractionEnabled = NO;
    }
    return _tipsLab;
}

// 点击按钮
- (UIButton *)clickButton
{
    if (_clickButton == nil) {
        _clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _clickButton.layer.cornerRadius = 3;
        _clickButton.layer.masksToBounds = YES;
        _clickButton.userInteractionEnabled = NO;
        [_clickButton setTitleColor:HEXCOLOR(0xb6b6b6) forState:UIControlStateNormal];
    }
    return _clickButton;
}

@end



@implementation EmptyProperty

@end
