//
//  XBFactoryTool.h
//  TongMeng
//
//  Created by xxb on 2019/1/19.
//  Copyright © 2019年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XBButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface XBFactoryTool : NSObject


#pragma mark - 创建tableView
/**
 根据数据源，代理，cell复用信息创建tableView
 */
+ (UITableView *)createTableViewWithDataSource:(id __nullable)dataSource delegate:(id __nullable)delegate registerCellInfoArr:(NSArray * __nullable)registerCellInfoArr;

/**
 根据数据源，代理，tableHeaderView，tableFooterView，cell复用信息创建tableView
 */
+ (UITableView *)createTableViewWithDataSource:(id __nullable)dataSource delegate:(id __nullable)delegate headerView:(UIView * __nullable)headerView footerView:(UIView * __nullable)footerView registerCellInfoArr:(NSArray * __nullable)registerCellInfoArr;

/**
 根据各种熟悉创建tableView
 registerCellInfoArr: @[@[className,reuseID],@[className,reuseID],...]
 registerSectionHeaderFooterInfoArr同上
 */
+ (UITableView *)createTableViewWithDataSource:(id __nullable)dataSource delegate:(id __nullable)delegate headerView:(UIView * __nullable)headerView footerView:(UIView * __nullable)footerView registerCellInfoArr:(NSArray * __nullable)registerCellInfoArr registerSectionHeaderFooterInfoArr:(NSArray * __nullable)registerSectionHeaderFooterInfoArr;


#pragma mark - 创建label
/**
 根据文字，字体，文字颜色创建label
 */
+ (UILabel *)createLabelWithText:(NSString * __nullable)text font:(UIFont * __nullable)font textColor:(UIColor * __nullable)textColor;
/**
 根据各种属性创建label
 */
+ (UILabel *)createLabelWithText:(NSString * __nullable)text font:(UIFont * __nullable)font textColor:(UIColor * __nullable)textColor textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor * __nullable)backgroundColor;


#pragma mark - 创建button
/**
 创建图片在上，文字在下的button
 */
+ (XBButton *)createImageTopButtonWithImage:(UIImage *)image title:(NSString *)title;
/**
 创建图片在上，文字在下的button
 */
+ (XBButton *)createImageTopButtonWithImage:(UIImage *)image imageSize:(CGSize)imageSize title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;
/**
 提交按钮
 */
+ (XBButton *)createCommitButtonWithTitle:(NSString * __nullable)title;

/**
 根据文字，字体，文字颜色，背景颜色创建button
 */
+ (XBButton *)createButtonWithTitle:(NSString * __nullable)title font:(UIFont * __nullable)font titleColor:(UIColor * __nullable)titleColor backgroundColor:(UIColor * __nullable)backgroundColor;

/**
 根据各种属性创建button
 */
+ (XBButton *)createButtonWithTitle:(NSString * __nullable)title selectedTitle:(NSString * __nullable)selectedTitle titleFont:(UIFont * __nullable)titleFont titleColor:(UIColor * __nullable)titleColor titleColorSelected:(UIColor * __nullable)titleColorSelected backgroundColor:(UIColor * __nullable)backgroundColor backgroundColorSelected:(UIColor * __nullable)backgroundColorSelected;
@end

NS_ASSUME_NONNULL_END
