//
//  CCPopMoreView.h
//  GundamSales
//
//  Created by 崔冰smile on 2018/12/26.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPopMoreViewModel.h"

typedef void(^SelectedItemBlock)(CCPopMoreViewModel *model);

@interface CCPopMoreView : UIView
/**
 弹出视图
 
 @param view 添加view
 @param items 展示的item
 @param block 点击回调
 */
+ (instancetype)showToView:(UIView *)view withItems:(NSArray *)items SelectedItemBlock:(SelectedItemBlock)block;

@end


