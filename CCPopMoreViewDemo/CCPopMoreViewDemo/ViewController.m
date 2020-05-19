//
//  ViewController.m
//  CCPopMoreViewDemo
//
//  Created by 崔冰smile on 2019/1/8.
//  Copyright © 2019年 Ziwutong. All rights reserved.
//

#import "ViewController.h"
#import "CCPopMoreView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *lblTip = ({
        UILabel *lbl = [[UILabel alloc] init];
        lbl.text = @"点击空白处弹出view";
        lbl;
    });
    [self.view addSubview:lblTip];
    [lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableArray *moreArray = [NSMutableArray array];
    for (int i = 0; i < 8; i ++) {
        CCPopMoreViewModel *model = [CCPopMoreViewModel new];
        model.title = [NSString stringWithFormat:@"测试%@",@(i)];
        model.iconUrl = @"";
        [moreArray addObject:model];
    }
    
    [CCPopMoreView showToView:self.view withItems:moreArray SelectedItemBlock:^(CCPopMoreViewModel *model) {
        NSLog(@"点击了%@",model.title);
    }];
}


@end
