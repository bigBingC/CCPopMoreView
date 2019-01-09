//
//  CCPopMoreViewItem.h
//  GundamSales
//
//  Created by 崔冰smile on 2018/12/26.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPopMoreViewModel.h"

typedef void(^ClickItemBlock)(CCPopMoreViewModel *itemModel);

@interface CCPopMoreViewItem : UIView
/**
 item  配置
 
 @param itemModel 数据源
 @param block 回调
 */
- (void)configItemView:(CCPopMoreViewModel *)itemModel clickItemBlock:(ClickItemBlock)block;
@end
