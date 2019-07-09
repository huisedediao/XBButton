//
//  XBButton+CompatibleUIButton.h
//  XBButton
//
//  Created by xxb on 2019/1/21.
//  Copyright © 2019年 谢贤彬. All rights reserved.
//

#import "XBButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface XBButton (CompatibleUIButton)
+ (instancetype)buttonWithType:(UIButtonType)buttonType;
- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state;
- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state;
//- (void)setTitleShadowColor:(nullable UIColor *)color forState:(UIControlState)state;
- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state;
- (nullable NSString *)titleForState:(UIControlState)state;
- (nullable UIColor *)titleColorForState:(UIControlState)state;
//- (nullable UIColor *)titleShadowColorForState:(UIControlState)state;
- (nullable UIImage *)imageForState:(UIControlState)state;
- (nullable UIImage *)backgroundImageForState:(UIControlState)state;
- (nullable NSAttributedString *)attributedTitleForState:(UIControlState)state;
- (nullable UILabel *)titleLabel;
- (nullable UIImageView *)imageView;
- (nullable NSString *)currentTitle;
- (nullable UIColor *)currentTitleColor;
- (nullable UIImage *)currentImage;
- (nullable UIImage *)currentBackgroundImage;
- (nullable NSAttributedString *)currentAttributedTitle;

@end

NS_ASSUME_NONNULL_END
