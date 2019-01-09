//
//  CCPopMoreView.m
//  GundamSales
//
//  Created by 崔冰smile on 2018/12/26.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "CCPopMoreView.h"
#import "UIImage+Effects.h"
#import "CCPopMoreViewModel.h"
#import "CCPopMoreViewItem.h"
#import "Masonry.h"
#import "UIColor+Common.h"

#define kTabbar_Height ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

static NSInteger const kColumnCount = 3;
static NSTimeInterval kAnimationDuration = 0.3;

@interface CCPopMoreView ()<UIScrollViewDelegate>
//背景
@property (nonatomic, strong) UIImageView *bgImageView;
//全屏取消
@property (nonatomic, strong) UIButton *bgCancel;
//底部取消视图
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *btnCancel;
//item视图
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) SelectedItemBlock selectedBlock;
@end

@implementation CCPopMoreView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubViews];
    }
    return self;
}

- (void)initWithSubViews {
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.bgCancel];
    [self.bgCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(kTabbar_Height);
    }];
    
    [self.bottomView addSubview:self.btnCancel];
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bottomView);
    }];
}

+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)items SelectedItemBlock:(SelectedItemBlock)block {
    CCPopMoreView *popView = [[CCPopMoreView alloc] initWithFrame:view.frame];
    popView.bgImageView.image = [popView imageWithView:view];
    [view addSubview:popView];
    popView.selectedBlock = block;
    popView.items = items;
    [popView createItemView];
    [popView setupItem];
    return popView;
}

- (void)createItemView {
    CGFloat height = self.items.count > 3 ? 210 : 100;
    NSInteger pages = (self.items.count - 1) /(kColumnCount * 2) + 1;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*pages, 0);
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-91);
        make.height.mas_equalTo(height);
    }];
    
    if (pages > 1) {
        self.pageControl.numberOfPages = pages;
        [self addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.scrollView.mas_bottom).offset(10);
            make.height.mas_equalTo(20);
            make.left.right.equalTo(self);
        }];
    }
}

- (void)setupItem {
    CGFloat vMargin = 15;
    CGFloat vSpacing = 20;
    CGFloat itemWidth = self.scrollView.frame.size.width / kColumnCount;
    CGFloat itemHeight = 80;
    NSInteger row = 0;
    NSInteger loc = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger index = 0; index < self.items.count; index ++) {
        row = index / kColumnCount % 2; // % 2  为了翻页
        loc = index % kColumnCount ;
        x = itemWidth * loc + (index / (kColumnCount * 2)) * self.scrollView.frame.size.width;
        if (index / (kColumnCount * 2) > 0) {
            y = vMargin + (itemWidth + vSpacing) * row;
        } else {
            y = self.scrollView.frame.size.height + (itemHeight + vSpacing) * row;
        }
        CCPopMoreViewModel *model = self.items[index];
        CCPopMoreViewItem *itemView = [[CCPopMoreViewItem alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        itemView.tag = 1000 + index;
        __weak typeof(self) weakSelf = self;
        [itemView configItemView:model clickItemBlock:^(CCPopMoreViewModel *itemModel) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.alpha = 0;
            } completion:^(BOOL finished) {
                [weakSelf removeFromSuperview];
            }];
            if (weakSelf.selectedBlock) {
                weakSelf.selectedBlock(itemModel);
            }
        }];
        
        [self.scrollView addSubview:itemView];
        
        if (index < kColumnCount * 2) {
            [UIView animateWithDuration:kAnimationDuration
                                  delay:index * 0.03
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.04
                                options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                    itemView.frame  = CGRectMake(itemWidth * loc, vMargin + (itemHeight + vSpacing) * row, itemWidth, itemHeight);
                                } completion:^(BOOL finished) {
                                }];
        }
    }
}


- (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image p_imageApplyBlurWithRadius:15 tintColor:CCColorAlpha_16(@"FFFFFF", 0.7) saturationDeltaFactor:1 maskImage:nil];
    UIGraphicsEndImageContext();
    return image;
}

- (void)clickCancelButton {
    self.pageControl.hidden = YES;
    
    CGFloat dy = CGRectGetHeight(self.frame) + 70;
    NSInteger count = 0;
    if (self.items.count / (kColumnCount * 2) > self.currentPage) {
        count = kColumnCount * 2; // 当前要具有 kColumnCount * 2个按钮;
    } else {
        count = self.items.count % (kColumnCount * 2); // 最后一页
    }
    
    for (int index = 0; index < count; index ++) {
        CCPopMoreViewItem *itemView = [self viewWithTag:1000 + self.currentPage * (kColumnCount * 2)  + index];
        CGFloat width = CGRectGetWidth(itemView.frame);
        CGFloat itemX = itemView.frame.origin.x;
        [UIView animateWithDuration:kAnimationDuration
                              delay:0.03 * count - index * 0.03
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.04
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                itemView.frame  = CGRectMake(itemX, dy, width, width);
                            } completion:^(BOOL finished) {
                                [self removeFromSuperview];
                            }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.currentPage = page;
    // 设置页码
    self.pageControl.currentPage = page;
}

#pragma mark - get
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

- (UIButton *)bgCancel {
    if (!_bgCancel) {
        _bgCancel = [[UIButton alloc] init];
        [_bgCancel addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgCancel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = CCColor_16(@"F3F4F6");
    }
    return _bottomView;
}

- (UIButton *)btnCancel {
    if (!_btnCancel) {
        _btnCancel = [[UIButton alloc] init];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:CCColor_16(@"333333") forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnCancel addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCancel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.37, self.frame.size.width, 300)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, self.bounds.size.height-89, 20, 20);
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = CCColor_16(@"797979");
        _pageControl.currentPageIndicatorTintColor = CCColor_16(@"30cad6");
    }
    return _pageControl;
}
@end
