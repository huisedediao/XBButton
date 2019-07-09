//
//  XBButton.m
//  DrawTest
//
//  Created by xxb on 2017/11/2.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "XBButton.h"
#import "Masonry.h"
#import <objc/message.h>

@interface XBButton ()
@property (nonatomic,strong) UIView *v_content;
@end

@implementation XBButton

- (void)layoutSubviews
{
    //解决没有设置宽高的时候无法显示的问题
    if (self.frame.size.width == 0 || self.frame.size.height == 0)
    {
        self.frame = CGRectMake(0, 0, 1, 1);
    }
    [self setNeedsDisplay];
}

#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initParams];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initParams];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self setBackgroundImageIfNeed];
    
    [self setTitleLabelContentIfNeed];
    [self setImageIfNeed];
    
    if (_lb_title || _imgv_image)
    {
        [self clearContentViewLayout];

        if (_lb_title && _imgv_image)
        {
            [self setContentViewSubviewsLayout];
        }
        else if (_lb_title)
        {
            [self setLableLayoutForNonImage];
        }
        else if (_imgv_image)
        {
            [self setImageViewLayoutForNonTitle];
        }
        
        [self setContentLayout];
        [self setContentAdaptLayoutIfNeed];
    }
    
    [self setHighLightOrSelectedBackgroundColorIfNeed:rect];
    [self sendBGImageViewToBackIfNeed];
}
- (void)dealloc
{
    NSLog(@"%@销毁",NSStringFromClass([self class]));
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *keyPath = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        [self removeObserver:self forKeyPath:[keyPath substringFromIndex:1]];
    }
}

#pragma mark - 初始化
- (void)initParams
{
    self.b_adaptContent = YES;
    self.layer.masksToBounds = YES;
    [self addTarget:self action:@selector(selfClick) forControlEvents:UIControlEventTouchUpInside];
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *keyPath = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        [self addObserver:self forKeyPath:[keyPath substringFromIndex:1] options:NSKeyValueObservingOptionNew context:nil];
    }
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - 观察者回调
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self setNeedsDisplay];
    
    if (_lb_title == nil)
    {
        if ([keyPath hasPrefix:@"str_"] || [keyPath hasPrefix:@"lb_"])
        {
            [self createTitleLabel];
        }
    }
    
    if (_imgv_image == nil)
    {
        if ([keyPath hasPrefix:@"img_"] || [keyPath hasPrefix:@"imgv_"])
        {
            [self createImageView];
        }
    }
    
}

#pragma mark - 设置参数
- (void)setTitleLabelContentIfNeed
{
    if ([self setAttributeStrIfNeed] == NO)
    {
        if ([self setTitleIfNeed])
        {
            [self setTitleNumberOfLinesIfNeed];
            [self setTitleColorIfNeed];
            [self setFontIfNeed];
        }
    }
    else
    {
        [self setTitleNumberOfLinesIfNeed];
    }
}

///返回：是否设置了富文本
- (BOOL)setAttributeStrIfNeed
{
    if (self.isEnabled == NO)
    {
        if (self.str_titleAttributedDisabled)
        {
            self.lb_title.attributedText = self.str_titleAttributedDisabled;
            return YES;
        }
    }
    if (self.isHighlighted)
    {
        if (self.str_titleAttributedHighlighted)
        {
            self.lb_title.attributedText = self.str_titleAttributedHighlighted;
            return YES;
        }
    }
    if (self.isSelected)
    {
        if (self.str_titleAttributedSelected)
        {
            self.lb_title.attributedText = self.str_titleAttributedSelected;
            return YES;
        }
    }
    if (self.str_titleAttributedNormal)
    {
        self.lb_title.attributedText = self.str_titleAttributedNormal;
        return YES;
    }
    return NO;
}

///返回：是否设置了title
- (BOOL)setTitleIfNeed
{
    NSString *title = [self getTitle];
    if (title.length)
    {
        self.lb_title.text = title;
        return YES;
    }
    return NO;
}

- (void)setTitleColorIfNeed
{
    UIColor *titleColor = [self getTitleColor];
    if (titleColor)
    {
        self.lb_title.textColor = titleColor;
    }
}

- (void)setImageIfNeed
{
    UIImage *img_content = [self getImage];
    if (img_content)
    {
        self.imgv_image.image = img_content;
    }
}

- (void)setFontIfNeed
{
    UIFont *font = self.font_title;
    if (font)
    {
        self.lb_title.font = font;
    }
}

- (void)setTitleNumberOfLinesIfNeed
{
    if (self.b_multiLine)
    {
        self.lb_title.numberOfLines = 0;
    }
    else
    {
        self.lb_title.numberOfLines = 1;
    }
}

- (void)setBackgroundImageIfNeed
{
    UIImage *img_background = [self getBackgroundImage];
    if (img_background)
    {
        self.imgv_background.image = img_background;
    }
}

- (void)setHighLightOrSelectedBackgroundColorIfNeed:(CGRect)rect
{
    if (self.isEnabled == NO)
    {
        if (self.color_backgroundDisabled)
        {
            [self.color_backgroundDisabled set];
            UIRectFill(rect);
        }
    }
    if (self.isHighlighted)
    {
        if(self.color_backgroundHighlight)
        {
            [self.color_backgroundHighlight set];
            UIRectFill(rect);
        }
    }
    else if (self.isSelected)
    {
        if(self.color_backgroundSelected)
        {
            [self.color_backgroundSelected set];
            UIRectFill(rect);
        }
    }
}
- (void)sendBGImageViewToBackIfNeed
{
    if (_imgv_background)
    {
        [self sendSubviewToBack:_imgv_background];
    }
}


#pragma mark - 获取用于显示的属性
- (UIImage *)getImage
{
    if (self.isEnabled == NO)
    {
        if (self.img_disabled)
        {
            return self.img_disabled;
        }
    }
    if (self.isHighlighted)
    {
        if (self.img_highlighted)
        {
            return self.img_highlighted;
        }
    }
    if (self.isSelected)
    {
        if (self.img_selected)
        {
            return self.img_selected;
        }
    }
    return self.img_normal;
}
- (NSString *)getTitle
{
    if (self.isEnabled == NO)
    {
        if (self.str_titleDisabled)
        {
            return self.str_titleDisabled;
        }
    }
    if (self.isHighlighted)
    {
        if (self.str_titleHighlighted)
        {
            return self.str_titleHighlighted;
        }
    }
    if (self.isSelected)
    {
        if (self.str_titleSelected)
        {
            return self.str_titleSelected;
        }
    }
    return self.str_titleNormal;
}
- (UIColor *)getTitleColor
{
    if (self.isEnabled == NO)
    {
        if (self.color_titleDisabled)
        {
            return self.color_titleDisabled;
        }
    }
    if (self.isHighlighted)
    {
        if (self.color_titleHighlighted)
        {
            return self.color_titleHighlighted;
        }
    }
    if (self.isSelected)
    {
        if (self.color_titleSelected)
        {
            return self.color_titleSelected;
        }
    }
    return self.color_titleNormal;
}
- (UIImage *)getBackgroundImage
{
    if (self.isEnabled == NO)
    {
        if (self.img_backgroundDisabled)
        {
            return self.img_backgroundDisabled;
        }
    }
    if (self.isHighlighted)
    {
        if (self.img_backgroundHighlighted)
        {
            return self.img_backgroundHighlighted;
        }
    }
    if (self.isSelected)
    {
        if (self.img_backgroundSelected)
        {
            return self.img_backgroundSelected;
        }
    }
    return self.img_backgroundNormal;
}

- (CGSize)getImageSize
{
    CGSize imageSize = CGSizeZero;
    if (CGSizeEqualToSize(self.size_image, CGSizeZero) == false)
    {
        if ([self getImage])
        {
            imageSize = self.size_image;
        }
    }
    else
    {
        imageSize = [self getImage].size;
    }
    if (self.b_keepImageScale)
    {
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat maxHeight = self.bounds.size.height;
        CGFloat maxWidth = self.bounds.size.width;
        //如果图片尺寸大于view尺寸，按比例缩放
        if(width > maxWidth || height > width)
        {
            CGFloat ratio = height / width;
            CGFloat maxRatio = maxHeight / maxWidth;
            if(ratio < maxRatio)
            {
                width = maxWidth;
                height = width*ratio;
            }
            else
            {
                height = maxHeight;
                width = height / ratio;
            }
        }
        imageSize.height = height;
        imageSize.width = width;
    }
    return imageSize;
}

#pragma mark - 方法重写
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsLayout];
}

#pragma mark - 点击事件
-(void)selfClick{}
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.bl_click)
    {
        self.bl_click(self);
    }
    else
    {
        [super sendAction:action to:target forEvent:event];
    }
}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (target == self)
    {
        if ([self actionsForTarget:self forControlEvent:controlEvents])
        {
            return;
        }
        [super addTarget:target action:action forControlEvents:controlEvents];
    }
    else
    {
        if ([self actionsForTarget:self forControlEvent:controlEvents])
        {
            [self removeTarget:self action:action forControlEvents:controlEvents];
        }
        [super addTarget:target action:action forControlEvents:controlEvents];
    }
}

#pragma mark - 布局
- (void)setLableLayoutForNonImage
{
    [self.lb_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.greaterThanOrEqualTo(self.v_content);
        make.right.bottom.lessThanOrEqualTo(self.v_content);
        make.center.equalTo(self.v_content);
    }];
}
- (void)setImageViewLayoutForNonTitle
{
    [self.imgv_image mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([self getImageSize]);
        make.center.equalTo(self.v_content);
        make.left.top.greaterThanOrEqualTo(self.v_content);
        make.right.bottom.lessThanOrEqualTo(self.v_content);
    }];
}

- (void)setContentViewSubviewsLayout
{
    [self.imgv_image mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.lb_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo([self getImageSize]);
    }];
    
    switch (self.enum_contentType)
    {
        case XBBtnTypeImageLeft:
        {
            [self contentSubviewsLayoutForType_left];
        }
            break;
        case XBBtnTypeImageRight:
        {
            [self contentSubviewsLayoutForType_right];
        }
            break;
        case XBBtnTypeImageTop:
        {
            [self contentSubviewsLayoutForType_top];
        }
            break;
        case XBBtnTypeImageBottom:
        {
            [self contentSubviewsLayoutForType_bottom];
        }
            break;
            
        default:
            break;
    }
}
- (void)clearContentViewLayout
{
    [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
}
- (void)setContentLayout
{
    switch (self.enum_contentAlign)
    {
        case XBBtnAlignEachSide:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                if (self.enum_contentType == XBBtnTypeImageLeft || self.enum_contentType == XBBtnTypeImageRight)
                {
                    make.left.equalTo(self).offset(self.f_spaceOfContentAndBorderForAlign);
                    make.right.equalTo(self).offset(- self.f_spaceOfContentAndBorderForAlign);
                }
                else
                {
                    make.top.equalTo(self).offset(self.f_spaceOfContentAndBorderForAlign);
                    make.bottom.equalTo(self).offset(- self.f_spaceOfContentAndBorderForAlign);
                }
            }];
        }
            break;
        case XBBtnAlignCenter:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        }
            break;
        case XBBtnAlignLeft:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(self.f_spaceOfContentAndBorderForAlign);
            }];
        }
            break;
        case XBBtnAlignRight:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(- self.f_spaceOfContentAndBorderForAlign);
            }];
        }
            break;
        case XBBtnAlignTop:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(self.f_spaceOfContentAndBorderForAlign);
            }];
        }
            break;
        case XBBtnAlignBottom:
        {
            [self.v_content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self).offset(- self.f_spaceOfContentAndBorderForAlign);
            }];
        }
            break;
            
        default:
            break;
    }
}
- (void)setContentAdaptLayoutIfNeed
{
    if (self.b_adaptContent)
    {
        if (self.enum_contentAlign == XBBtnAlignCenter)
        {
            [self.v_content mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self).offset(self.f_spaceOfContentAndBorderForAdapt);
                make.right.lessThanOrEqualTo(self).offset(- self.f_spaceOfContentAndBorderForAdapt);
                make.top.greaterThanOrEqualTo(self).offset(self.f_spaceOfContentAndBorderForAdapt);
                make.bottom.lessThanOrEqualTo(self).offset(- self.f_spaceOfContentAndBorderForAdapt);
            }];
        }
    }
}
- (void)contentSubviewsLayoutForType_left
{
    if (self.enum_contentAlign == XBBtnAlignEachSide)
    {
        [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.v_content);
            make.centerY.equalTo(self.v_content);
            make.bottom.lessThanOrEqualTo(self.v_content);
            make.top.greaterThanOrEqualTo(self.v_content);
        }];
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.v_content);
            make.centerY.equalTo(self.v_content);
            make.top.greaterThanOrEqualTo(self.v_content);
            make.bottom.lessThanOrEqualTo(self.v_content);
        }];
        return;
    }
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
        make.top.greaterThanOrEqualTo(self.v_content);
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.imgv_image.mas_right).offset(self.f_spaceOfImageAndTitle);
        if (self.f_titleMaxWidth != 0)
        {
            make.width.mas_lessThanOrEqualTo(self.f_titleMaxWidth);
        }
        make.top.greaterThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
}
- (void)contentSubviewsLayoutForType_right
{
    if (self.enum_contentAlign == XBBtnAlignEachSide)
    {
        [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.v_content);
            make.centerY.equalTo(self.v_content);
            make.bottom.lessThanOrEqualTo(self.v_content);
            make.top.greaterThanOrEqualTo(self.v_content);
        }];
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.v_content);
            make.centerY.equalTo(self.v_content);
            make.top.greaterThanOrEqualTo(self.v_content);
            make.bottom.lessThanOrEqualTo(self.v_content);
        }];
        return;
    }
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.v_content);
        make.top.greaterThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
    }];
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.v_content);
        make.left.equalTo(self.lb_title.mas_right).offset(self.f_spaceOfImageAndTitle);
        if (self.f_titleMaxWidth != 0)
        {
            make.width.mas_lessThanOrEqualTo(self.f_titleMaxWidth);
        }
        make.top.greaterThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
}
- (void)contentSubviewsLayoutForType_top
{
    if (self.enum_contentAlign == XBBtnAlignEachSide)
    {
        [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.v_content);
            make.top.equalTo(self.v_content);
            make.left.greaterThanOrEqualTo(self.v_content);
            make.right.lessThanOrEqualTo(self.v_content);
        }];
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.v_content);
            make.bottom.equalTo(self.v_content);
            make.left.greaterThanOrEqualTo(self.v_content);
            make.right.lessThanOrEqualTo(self.v_content);
        }];
        return;
    }
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.top.equalTo(self.v_content);
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.top.equalTo(self.imgv_image.mas_bottom).offset(self.f_spaceOfImageAndTitle);
        if (self.f_titleMaxWidth != 0)
        {
            make.width.mas_lessThanOrEqualTo(self.f_titleMaxWidth);
        }
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
        make.bottom.lessThanOrEqualTo(self.v_content);
    }];
}
- (void)contentSubviewsLayoutForType_bottom
{
    if (self.enum_contentAlign == XBBtnAlignEachSide)
    {
        [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.v_content);
            make.bottom.equalTo(self.v_content);
            make.left.greaterThanOrEqualTo(self.v_content);
            make.right.lessThanOrEqualTo(self.v_content);
        }];
        [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.v_content);
            make.top.equalTo(self.v_content);
            make.left.greaterThanOrEqualTo(self.v_content);
            make.right.lessThanOrEqualTo(self.v_content);
        }];
        return;
    }
    [self.imgv_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.bottom.equalTo(self.v_content);
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
    }];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_content);
        make.bottom.equalTo(self.imgv_image.mas_top).offset(- self.f_spaceOfImageAndTitle);
        if (self.f_titleMaxWidth != 0)
        {
            make.width.mas_lessThanOrEqualTo(self.f_titleMaxWidth);
        }
        make.left.greaterThanOrEqualTo(self.v_content);
        make.right.lessThanOrEqualTo(self.v_content);
        make.top.greaterThanOrEqualTo(self.v_content);
    }];
}


#pragma mark - 懒加载
- (UIImageView *)imgv_background
{
    if (_imgv_background == nil)
    {
        _imgv_background = [UIImageView new];
        _imgv_background.userInteractionEnabled = NO;
        [self addSubview:_imgv_background];
        [_imgv_background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _imgv_background;
}
- (UIView *)v_content
{
    if (_v_content == nil)
    {
        _v_content = [UIView new];
        [self addSubview:_v_content];
        _v_content.userInteractionEnabled = NO;
    }
    return _v_content;
}
- (UILabel *)lb_title
{
    if (_lb_title == nil)
    {
        [self createTitleLabel];
    }
    return _lb_title;
}
- (UIImageView *)imgv_image
{
    if (_imgv_image == nil)
    {
        [self createImageView];
    }
    return _imgv_image;
}
- (void)createTitleLabel
{
    _lb_title = [UILabel new];
    [self.v_content addSubview:_lb_title];
}
- (void)createImageView
{
    _imgv_image = [UIImageView new];
    [self.v_content addSubview:_imgv_image];
}
@end
