//
//  UIColor+Common.m
//  CCPopMoreView
//
//  Created by 崔冰smile on 2019/1/8.
//

#import "UIColor+Common.h"

@implementation UIColor (Common)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:(arc4random()%256)/256.f
                           green:(arc4random()%256)/256.f
                            blue:(arc4random()%256)/256.f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexStr:(NSString *)hexStr{
    return [self colorWithHexStr:hexStr alpha:1.0];
}

+ (UIColor *)colorWithHexStr:(NSString *)hexStr alpha:(CGFloat)alpha{
    
    // 第一位是#号则去掉#号;
    if (hexStr && hexStr.length > 1 && [[hexStr substringToIndex:1] isEqualToString:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }
    
    // 如果色值不合法，返回白色
    if (!hexStr || hexStr.length != 6) {
        return [UIColor whiteColor];
    }
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:range]]scanHexInt:&blue];
    
    //要进行颜色的RGB设置，要进行对255.0的相除（与其他语言不同）
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
}

@end
