//
//  XBFactoryTool.m
//  TongMeng
//
//  Created by xxb on 2019/1/19.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import "XBFactoryTool.h"

@implementation XBFactoryTool

#pragma mark - 创建tableView
+ (UITableView *)createTableViewWithDataSource:(id __nullable)dataSource delegate:(id __nullable)delegate registerCellInfoArr:(NSArray * __nullable)registerCellInfoArr
{
    return [XBFactoryTool createTableViewWithDataSource:dataSource delegate:delegate headerView:nil footerView:nil registerCellInfoArr:registerCellInfoArr];
}

+ (UITableView *)createTableViewWithDataSource:(id __nullable)dataSource delegate:(id __nullable)delegate headerView:(UIView * __nullable)headerView footerView:(UIView * __nullable)footerView registerCellInfoArr:(NSArray * __nullable)registerCellInfoArr
{
    return [XBFactoryTool createTableViewWithDataSource:dataSource delegate:delegate headerView:headerView footerView:footerView registerCellInfoArr:registerCellInfoArr registerSectionHeaderFooterInfoArr:nil];
}

/**
 registerCellInfoArr: @[@[className,reuseID],@[className,reuseID],...]
 registerSectionHeaderFooterInfoArr同上
 */
+ (UITableView *)createTableViewWithDataSource:(id __nullable)dataSource delegate:(id __nullable)delegate headerView:(UIView * __nullable)headerView footerView:(UIView * __nullable)footerView registerCellInfoArr:(NSArray * __nullable)registerCellInfoArr registerSectionHeaderFooterInfoArr:(NSArray * __nullable)registerSectionHeaderFooterInfoArr
{
    UITableView *tableView = [UITableView new];
    tableView.dataSource = dataSource;
    tableView.delegate = delegate;
    if (headerView) tableView.tableHeaderView = headerView;
    tableView.tableFooterView = footerView ? footerView : [UIView new];
    for (NSArray *cellInfo in registerCellInfoArr)
    {
        [tableView registerClass:NSClassFromString(cellInfo[0]) forCellReuseIdentifier:cellInfo[1]];
    }
    for (NSArray *sectionHeaderFooterInfo in registerSectionHeaderFooterInfoArr)
    {
        [tableView registerClass:NSClassFromString(sectionHeaderFooterInfo[0]) forHeaderFooterViewReuseIdentifier:sectionHeaderFooterInfo[1]];
    }
    return tableView;
}

#pragma mark - 创建label
+ (UILabel *)createLabelWithText:(NSString * __nullable)text font:(UIFont * __nullable)font textColor:(UIColor * __nullable)textColor
{
    return [XBFactoryTool createLabelWithText:text font:font textColor:textColor textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor clearColor]];
}
+ (UILabel *)createLabelWithText:(NSString * __nullable)text font:(UIFont * __nullable)font textColor:(UIColor * __nullable)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor * __nullable)backgroundColor
{
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.backgroundColor = backgroundColor;
    label.textAlignment = textAlignment;
    return label;
}


#pragma mark - 创建button
/**
 创建图片在上，文字在下的button
 */
+ (XBButton *)createImageTopButtonWithImage:(UIImage *)image title:(NSString *)title
{
    return [XBFactoryTool createImageTopButtonWithImage:image imageSize:CGSizeMake(30, 30) title:title titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
}
/**
 创建图片在上，文字在下的button
 */
+ (XBButton *)createImageTopButtonWithImage:(UIImage *)image imageSize:(CGSize)imageSize title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font
{
    XBButton *button = [XBButton new];
    button.enum_contentType = XBBtnTypeImageTop;
    if (CGSizeEqualToSize(CGSizeZero, imageSize) == NO)
    {
        button.size_image = imageSize;
    }
    button.img_normal = image;
    button.str_titleNormal = title;
    button.font_title = font;
    button.color_titleNormal = titleColor;
    return button;
}
+ (XBButton *)createButtonWithTitle:(NSString * __nullable)title font:(UIFont * __nullable)font titleColor:(UIColor * __nullable)titleColor backgroundColor:(UIColor * __nullable)backgroundColor
{
    return [XBFactoryTool createButtonWithTitle:title selectedTitle:nil titleFont:font titleColor:titleColor titleColorSelected:nil backgroundColor:backgroundColor backgroundColorSelected:[backgroundColor colorWithAlphaComponent:0.7]];
}

+ (XBButton *)createCommitButtonWithTitle:(NSString * __nullable)title
{
    XBButton *btn = [XBFactoryTool createButtonWithTitle:title selectedTitle:nil titleFont:nil titleColor:nil titleColorSelected:nil backgroundColor:[UIColor clearColor] backgroundColorSelected:nil];
//    btn.layer.cornerRadius = ;
    return btn;
}

+ (XBButton *)createButtonWithTitle:(NSString * __nullable)title selectedTitle:(NSString * __nullable)selectedTitle titleFont:(UIFont * __nullable)titleFont titleColor:(UIColor * __nullable)titleColor titleColorSelected:(UIColor * __nullable)titleColorSelected backgroundColor:(UIColor * __nullable)backgroundColor backgroundColorSelected:(UIColor * __nullable)backgroundColorSelected
{
    XBButton *btn = [XBButton new];
    btn.str_titleNormal = title;
    btn.str_titleSelected = selectedTitle;
    btn.font_title = titleFont;
    btn.color_titleNormal = titleColor;
    btn.color_titleSelected = titleColorSelected;
    btn.backgroundColor = backgroundColor;
    btn.color_backgroundSelected = backgroundColorSelected;
    return btn;
}
@end
