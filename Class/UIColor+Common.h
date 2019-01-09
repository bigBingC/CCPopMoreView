//
//  UIColor+Common.h
//  CCPopMoreView
//
//  Created by 崔冰smile on 2019/1/8.
//

#import <UIKit/UIKit.h>

#define CCColor_16(r)                  [UIColor colorWithHexStr:r]
#define CCColorAlpha_16(r,a)           [UIColor colorWithHexStr:r alpha:a]

@interface UIColor (Common)

+ (UIColor *)randomColor;
+ (UIColor *)colorWithHexStr:(NSString *)hexStr;
+ (UIColor *)colorWithHexStr:(NSString *)hexStr alpha:(CGFloat)alpha;

@end


