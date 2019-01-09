//
//  CCPopMoreViewItem.m
//  GundamSales
//
//  Created by 崔冰smile on 2018/12/26.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import "CCPopMoreViewItem.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CCPopMoreViewItem ()
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnSelect;
@property (nonatomic, copy) ClickItemBlock clickBlock;
@property (nonatomic, strong) CCPopMoreViewModel *itemModel;
@end

@implementation CCPopMoreViewItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithSubviews];
    }
    return self;
}

- (void)initWithSubviews {
    [self addSubview:self.imgIcon];
    [self addSubview:self.lblTitle];
    [self addSubview:self.btnSelect];

    [self.imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.height.width.mas_equalTo(50);
    }];
    
    [self.lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.imgIcon.mas_bottom).offset(8);
    }];
    
    [self.btnSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)configItemView:(CCPopMoreViewModel *)itemModel clickItemBlock:(ClickItemBlock)block {
    self.itemModel = itemModel;
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:itemModel.iconUrl]];
    self.lblTitle.text = itemModel.title;
    self.clickBlock = block;
}

- (void)clickItem {
    if (self.clickBlock) {
        self.clickBlock(self.itemModel);
    }
}

#pragma mark - get
- (UIImageView *)imgIcon {
    if (!_imgIcon) {
        _imgIcon = [[UIImageView alloc] init];
    }
    return _imgIcon;
}

- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor grayColor];
        _lblTitle.font = [UIFont systemFontOfSize:13];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _lblTitle;
}

- (UIButton *)btnSelect {
    if (!_btnSelect) {
        _btnSelect = [[UIButton alloc] init];
        [_btnSelect addTarget:self action:@selector(clickItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSelect;
}
@end
