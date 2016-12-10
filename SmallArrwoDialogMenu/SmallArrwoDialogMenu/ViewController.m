//
//  ViewController.m
//  SmallArrwoDialogMenu
//
//  Created by yaoshuai on 2016/12/10.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "ViewController.h"
#import "YSMenu.h"

@interface ViewController ()

@property (nonatomic , strong) NSMutableArray *items;

@end

@implementation ViewController
@synthesize items = _items;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotification];
}

#pragma mark - 设置数据
- (NSMutableArray *)items {
    if (!_items) {
        
        // set title
        YSMenuItem *menuTitle = [YSMenuItem menuTitle:@"Menu" WithIcon:nil];
        menuTitle.foreColor = [UIColor whiteColor];
        menuTitle.titleFont = [UIFont boldSystemFontOfSize:20.0f];
        
        //set logout button
        YSMenuItem *logoutItem = [YSMenuItem menuItem:@"退出" image:nil target:self action:@selector(logout:)];
        logoutItem.foreColor = [UIColor redColor];
        logoutItem.alignment = NSTextAlignmentCenter;
        
        //set item
        _items = [@[menuTitle,
                    [YSMenuItem menuItem:@"个人中心"
                                   image:nil
                                     tag:100
                                userInfo:@{@"title":@"Menu"}],
                    [YSMenuItem menuItem:@"ACTION 133"
                                   image:nil
                                     tag:101
                                userInfo:@{@"title":@"Menu"}],
                    [YSMenuItem menuItem:@"检查更新"
                                   image:nil
                                     tag:102
                                userInfo:@{@"title":@"Menu"}],
                    logoutItem
                    ] mutableCopy];
    }
    return _items;
}
- (void)setItems:(NSMutableArray *)items {
    _items = items;
}

#pragma mark - 弹框事件
- (void)logout:(id)sender {
    NSLog(@"logout");
}

- (IBAction)showMenuFromRightNavigationBarItem:(id)sender {
    
    // 通过NavigationBarItem显示Menu
    if (sender == self.navigationItem.rightBarButtonItem) {
        [YSMenu setTintColor:[UIColor colorWithRed:0.118 green:0.573 blue:0.820 alpha:1]];
        [YSMenu setSelectedColor:[UIColor redColor]];
        if ([YSMenu isShow]){
            [YSMenu dismissMenu];
        } else {
            [YSMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 50, 0, 50, 0) menuItems:self.items selected:^(NSInteger index, YSMenuItem *item) {
                NSLog(@"%@",item);
            }];
        }
    }
}

- (IBAction)showMenuFromLeftNavigationBarItem:(id)sender {
    // 通过NavigationBarItem显示Menu
    if (sender == self.navigationItem.leftBarButtonItem) {
        [YSMenu setTintColor:[UIColor colorWithRed:0.118 green:0.573 blue:0.820 alpha:1]];
        [YSMenu setSelectedColor:[UIColor redColor]];
        if ([YSMenu isShow]){
            [YSMenu dismissMenu];
        } else {
            [YSMenu showMenuInView:self.view fromRect:CGRectMake(0, 0, 50, 0) menuItems:self.items selected:^(NSInteger index, YSMenuItem *item) {
                NSLog(@"%@",item);
            }];
        }
    }
}

- (IBAction)showMenuFromLeftTop:(id)sender {
    UIButton *btn = sender;
    [YSMenu showMenuInView:self.view fromRect:btn.frame menuItems:self.items selected:^(NSInteger index, YSMenuItem *item) {
        NSLog(@"%@",item);
    }];
}

- (IBAction)showMenuFromRightBottom:(id)sender {
    // 显示默认样式的Menu
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = sender;
        [YSMenu setHasShadow:NO];
        [YSMenu setArrowSize:6];
        [YSMenu setCornerRadius:2];
        [YSMenu setBackgrounColorEffect:YSMenuBackgrounColorEffectSolid];
        [YSMenu setTintColor:[UIColor colorWithRed:0.212 green:0.255 blue:0.678 alpha:1]];
        [YSMenu showMenuInView:self.view fromRect:btn.frame menuItems:self.items selected:^(NSInteger index, YSMenuItem *item) {
            NSLog(@"%@",item);
        }];
    }
}

- (IBAction)showMenuFromLeftBottom:(id)sender {
    // 显示默认样式的Menu
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = sender;
        [YSMenu setHasShadow:YES];
        [YSMenu setBackgrounColorEffect:YSMenuBackgrounColorEffectGradient];
        [YSMenu setTintColor:[UIColor colorWithRed:0.212 green:0.255 blue:0.678 alpha:1]];
        [YSMenu showMenuInView:self.view fromRect:btn.frame menuItems:self.items selected:^(NSInteger index, YSMenuItem *item) {
            NSLog(@"%@",item);
        }];
    }
}

- (IBAction)showMenuFromCenter:(id)sender {
    // 显示默认样式的Menu
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = sender;
        [YSMenu setHasShadow:YES];
        [YSMenu setBackgrounColorEffect:YSMenuBackgrounColorEffectGradient];
        [YSMenu setTintColor:[UIColor colorWithRed:0.212 green:0.255 blue:0.678 alpha:1]];
        [YSMenu setSeparatorColor:[UIColor redColor]];
        [YSMenu setMenuItemMarginY:20];
        [YSMenu setTitleFont:[UIFont systemFontOfSize:24.0]];
        [YSMenu showMenuInView:self.view fromRect:btn.frame menuItems:self.items selected:^(NSInteger index, YSMenuItem *item) {
            NSLog(@"%@",item);
        }];
    }
}

#pragma mark - 通知行为、监听与移除
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillAppear) name:YSMenuWillAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidAppear) name:YSMenuDidAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillDisappear) name:YSMenuWillDisappearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidDisappear) name:YSMenuDidDisappearNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)menuWillAppear {
    NSLog(@"menu will appear");
}

- (void)menuDidAppear {
    NSLog(@"menu did appear");
}

- (void)menuWillDisappear {
    NSLog(@"menu will disappear");
}

- (void)menuDidDisappear {
    NSLog(@"menu did disappear");
}

@end
