//
//  ViewController.m
//  XBButton
//
//  Created by 谢贤彬 on 2019/1/13.
//  Copyright © 2019年 谢贤彬. All rights reserved.
//

#import "ViewController.h"
#import "XBButton+CompatibleUIButton.h"
#import "Masonry.h"
#import "XBFactoryTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self createButton1];
    
//    [self createButton2];
    
//    [self createButton3];
//    [self createButton4];
}

- (void)createButton1
{
    XBButton *btn = [XBButton new];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    //    btn.str_titleNormal = @"testBtn";
    //    btn.enum_contentAlign = XBBtnAlignBottom;
    //    btn.f_spaceOfContentAndBorderForAlign = 15;
    btn.f_verticallySpaceForAdapt = 15;
    btn.f_horizontalSpaceForAdapt = 30;
    btn.b_multiLine = YES;
    btn.str_titleAttributedNormal = [[NSAttributedString alloc] initWithString:@"testBtn.lkdkfjeifeiefij"];
    //    btn.lb_title.backgroundColor = [UIColor orangeColor];
    //    btn.lb_title.superview.backgroundColor = [UIColor greenColor];
    btn.backgroundColor = [UIColor redColor];
    
    btn.color_backgroundHighlight = [UIColor greenColor];
    btn.color_backgroundSelected = [UIColor purpleColor];
    btn.bl_click = ^(XBButton *weakBtn) {
        weakBtn.selected = !weakBtn.selected;
    };
    btn.img_normal = [UIImage imageNamed:@"testImg"];
}

- (void)createButton2
{
    XBButton *btn = [XBButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
//    [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"testBtn.lkdkfjeifeiefij"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn setImage:[UIImage imageNamed:@"testImg"] forState:UIControlStateNormal];
}

- (void)createButton3
{
    XBButton *btn = [XBFactoryTool createImageTopButtonWithImage:[UIImage imageNamed:@"testImg"] title:@"test"];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(self.view);
    }];
    btn.backgroundColor = [UIColor orangeColor];
}
- (void)createButton4
{
    XBButton *btn = [XBFactoryTool createImageTopButtonWithImage:[UIImage imageNamed:@"testImg"] title:@"test"];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.center.equalTo(self.view);
    }];
    btn.enum_contentAlign = XBBtnAlignEachSide;
    btn.f_spaceOfContentAndBorderForAlign = 5;
    btn.backgroundColor = [UIColor orangeColor];
}
@end
