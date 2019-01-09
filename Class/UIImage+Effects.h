//
//  UIImage+Effects.h
//  GundamSales
//
//  Created by 崔冰smile on 2018/12/26.
//  Copyright © 2018年 Ziwutong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Effects)

- (UIImage *)p_imageApplyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
