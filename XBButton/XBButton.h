//
//  XBButton.h
//  DrawTest
//
//  Created by xxb on 2017/11/2.
//  Copyright © 2017年 xxb. All rights reserved.
//


/**
 
    !!!!
    如果是作为navigationBar上的控件，
 
 系统版本大于等于ios11，需要这样设置size
 [btn_logo mas_makeConstraints:^(MASConstraintMaker *make) {
 make.size.mas_equalTo(CGSizeMake(GWidthFactorFunXSMaxBase5S(94), GWidthFactorFunXSMaxBase5S(39)));
 }];
 
 系统版本小于ios11，需要这样设置size
 btn_logo.frame = CGRectMake(0, 0, GWidthFactorFunXSMaxBase5S(94), GWidthFactorFunXSMaxBase5S(39));
 
 */

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XBBtnTypeImageLeft,//图片在左
    XBBtnTypeImageRight,//文字在左
    XBBtnTypeImageTop,//图片在上
    XBBtnTypeImageBottom//文字在上
} XBBtnContentType;

typedef enum : NSUInteger {
    XBBtnAlignCenter,
    XBBtnAlignLeft,
    XBBtnAlignRight,
    XBBtnAlignTop,
    XBBtnAlignBottom,
    XBBtnAlignEachSide//文字和图片各自向离其近的边对齐
} XBBtnContentAlign;

@class XBButton;

typedef void(^XBActionBlock)(XBButton *btn);

@interface XBButton : UIControl

@property (nonatomic,strong) UILabel *lb_title;
@property (nonatomic,strong) UIImageView *imgv_image;
@property (nonatomic,strong) UIImageView *imgv_background;

/** 图片和文字排布样式 ，默认图片在左*/
@property (nonatomic,assign) XBBtnContentType enum_contentType;

/** 内容（图片和文字）是靠哪个方向对齐，上下左右，默认居中 */
@property (nonatomic,assign) XBBtnContentAlign enum_contentAlign;

///文字的最大宽度
@property (nonatomic,assign) CGFloat f_titleMaxWidth;

///是否保持图片比例
@property (nonatomic,assign) BOOL b_keepImageScale;
///文字是否自动换行
@property (nonatomic,assign) BOOL b_multiLine;
///自适应内容宽高,默认自适应(只在XBBtnAlignCenter时生效)
@property (nonatomic,assign) BOOL b_adaptContent;

///自适应内容宽高时，内容距离边缘的距离，默认为0
@property (nonatomic,assign) CGFloat f_spaceOfContentAndBorderForAdapt;

/** 图片和文字的间距 */
@property (nonatomic,assign) CGFloat f_spaceOfImageAndTitle;

/** 内容（图片和文字）到对齐方向边缘的距离，内容在中间时不起作用 */
@property (nonatomic,assign) CGFloat f_spaceOfContentAndBorderForAlign;

@property (nonatomic,assign) CGSize size_image;

@property (nonatomic,strong) UIImage *img_normal;
@property (nonatomic,strong) UIImage *img_selected;
@property (nonatomic,strong) UIImage *img_highlighted;
@property (nonatomic,strong) UIImage *img_disabled;

@property (nonatomic,copy) NSString *str_titleNormal;
@property (nonatomic,copy) NSString *str_titleSelected;
@property (nonatomic,copy) NSString *str_titleHighlighted;
@property (nonatomic,copy) NSString *str_titleDisabled;

@property (nonatomic,copy) NSAttributedString *str_titleAttributedNormal;
@property (nonatomic,copy) NSAttributedString *str_titleAttributedSelected;
@property (nonatomic,copy) NSAttributedString *str_titleAttributedHighlighted;
@property (nonatomic,copy) NSAttributedString *str_titleAttributedDisabled;

@property (nonatomic,strong) UIColor *color_titleNormal;
@property (nonatomic,strong) UIColor *color_titleSelected;
@property (nonatomic,strong) UIColor *color_titleHighlighted;
@property (nonatomic,strong) UIColor *color_titleDisabled;

@property (nonatomic,strong) UIImage *img_backgroundNormal;
@property (nonatomic,strong) UIImage *img_backgroundSelected;
@property (nonatomic,strong) UIImage *img_backgroundHighlighted;
@property (nonatomic,strong) UIImage *img_backgroundDisabled;

@property (nonatomic,strong) UIColor *color_backgroundHighlight;
@property (nonatomic,strong) UIColor *color_backgroundSelected;
@property (nonatomic,strong) UIColor *color_backgroundDisabled;

@property (nonatomic,strong) UIFont *font_title;

/** 点击回调 */
@property (nonatomic,copy) XBActionBlock bl_click;

@end
