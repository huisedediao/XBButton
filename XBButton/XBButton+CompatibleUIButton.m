//
//  XBButton+CompatibleUIButton.m
//  XBButton
//
//  Created by xxb on 2019/1/21.
//  Copyright © 2019年 谢贤彬. All rights reserved.
//

#import "XBButton+CompatibleUIButton.h"

@implementation XBButton (CompatibleUIButton)

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    return [XBButton new];
}

- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            self.str_titleNormal = title;
        }
            break;
        case UIControlStateHighlighted:
        {
            self.str_titleHighlighted = title;
        }
            break;
        case UIControlStateSelected:
        {
            self.str_titleSelected = title;
        }
            break;
        case UIControlStateDisabled:
        {
            self.str_titleDisabled = title;
        }
            break;
            
        default:
            self.str_titleNormal = title;
            break;
    }
}
- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            self.color_titleNormal = color;
        }
            break;
        case UIControlStateHighlighted:
        {
            self.color_titleHighlighted = color;
        }
            break;
        case UIControlStateSelected:
        {
            self.color_titleSelected = color;
        }
            break;
        case UIControlStateDisabled:
        {
            self.color_titleDisabled = color;
        }
            break;
            
        default:
            self.color_titleNormal = color;
            break;
    }
}

//- (void)setTitleShadowColor:(nullable UIColor *)color forState:(UIControlState)state
//{
//    
//}

- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            self.img_normal = image;
        }
            break;
        case UIControlStateHighlighted:
        {
            self.img_highlighted = image;
        }
            break;
        case UIControlStateSelected:
        {
            self.img_selected = image;
        }
            break;
        case UIControlStateDisabled:
        {
            self.img_disabled = image;
        }
            break;
            
        default:
            self.img_normal = image;
            break;
    }
}

- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            self.img_backgroundNormal = image;
        }
            break;
        case UIControlStateHighlighted:
        {
            self.img_backgroundHighlighted = image;
        }
            break;
        case UIControlStateSelected:
        {
            self.img_backgroundSelected = image;
        }
            break;
        case UIControlStateDisabled:
        {
            self.img_backgroundDisabled = image;
        }
            break;
            
        default:
            self.img_backgroundNormal = image;
            break;
    }
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            self.str_titleAttributedNormal = title;
        }
            break;
        case UIControlStateHighlighted:
        {
            self.str_titleAttributedHighlighted = title;
        }
            break;
        case UIControlStateSelected:
        {
            self.str_titleAttributedSelected = title;
        }
            break;
        case UIControlStateDisabled:
        {
            self.str_titleAttributedDisabled = title;
        }
            break;
            
        default:
            self.str_titleAttributedNormal = title;
            break;
    }
}

- (nullable NSString *)titleForState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            return self.str_titleNormal;
        }
            break;
        case UIControlStateHighlighted:
        {
            return self.str_titleHighlighted;
        }
            break;
        case UIControlStateSelected:
        {
            return self.str_titleSelected;
        }
            break;
        case UIControlStateDisabled:
        {
            return self.str_titleDisabled;
        }
            break;
            
        default:
            return self.str_titleNormal;
            break;
    }
}

- (nullable UIColor *)titleColorForState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            return self.color_titleNormal;
        }
            break;
        case UIControlStateHighlighted:
        {
            return self.color_titleHighlighted;
        }
            break;
        case UIControlStateSelected:
        {
            return self.color_titleSelected;
        }
            break;
        case UIControlStateDisabled:
        {
            return self.color_titleDisabled;
        }
            break;
            
        default:
            return self.color_titleNormal;
            break;
    }
}

//- (nullable UIColor *)titleShadowColorForState:(UIControlState)state
//{
//    switch (state)
//    {
//        case UIControlStateNormal:
//        {
//
//        }
//            break;
//        case UIControlStateHighlighted:
//        {
//
//        }
//            break;
//        case UIControlStateSelected:
//        {
//
//        }
//            break;
//        case UIControlStateDisabled:
//        {
//
//        }
//            break;
//
//        default:
//
//            break;
//    }
//}

- (nullable UIImage *)imageForState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            return self.img_normal;
        }
            break;
        case UIControlStateHighlighted:
        {
            return self.img_highlighted;
        }
            break;
        case UIControlStateSelected:
        {
            return self.img_selected;
        }
            break;
        case UIControlStateDisabled:
        {
            return self.img_disabled;
        }
            break;
            
        default:
            return self.img_normal;
            break;
    }
}

- (nullable UIImage *)backgroundImageForState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            return self.img_backgroundNormal;
        }
            break;
        case UIControlStateHighlighted:
        {
            return self.img_backgroundHighlighted;
        }
            break;
        case UIControlStateSelected:
        {
            return self.img_backgroundSelected;
        }
            break;
        case UIControlStateDisabled:
        {
            return self.img_backgroundDisabled;
        }
            break;
            
        default:
            return self.img_backgroundNormal;
            break;
    }
}

- (nullable NSAttributedString *)attributedTitleForState:(UIControlState)state
{
    switch (state)
    {
        case UIControlStateNormal:
        {
            return self.str_titleAttributedNormal;
        }
            break;
        case UIControlStateHighlighted:
        {
            return self.str_titleAttributedHighlighted;
        }
            break;
        case UIControlStateSelected:
        {
            return self.str_titleAttributedSelected;
        }
            break;
        case UIControlStateDisabled:
        {
            return self.str_titleAttributedDisabled;
        }
            break;
            
        default:
            return self.str_titleAttributedNormal;
            break;
    }
}

- (nullable UILabel *)titleLabel
{
    return self.lb_title;
}

- (nullable UIImageView *)imageView
{
    return self.imgv_image;
}

- (nullable NSString *)currentTitle
{
    return self.lb_title.text;
}

- (nullable UIColor *)currentTitleColor
{
    return self.lb_title.textColor;
}

- (nullable UIImage *)currentImage
{
    return self.imgv_image.image;
}

- (nullable UIImage *)currentBackgroundImage
{
    return self.imgv_background.image;
}

- (nullable NSAttributedString *)currentAttributedTitle
{
    return self.lb_title.attributedText;
}

@end
