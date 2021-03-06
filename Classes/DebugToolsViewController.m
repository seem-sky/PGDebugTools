//
//  DebugToolsViewController.m
//  jiuxian
//
//  Created by 张正超 on 15/12/2.
//  Copyright © 2015年 jiuxian.com. All rights reserved.
//

#import "DebugToolsViewController.h"
#import "DebugDataManage.h"
#import "DataManagerSource.h"
#import "Masonry.h"

#define weakself typeof(self) __weak bself = self;

@interface DebugToolsViewController ()


@property(nonatomic, strong) UILabel *navBar;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) DebugDataManage *dataManage;

@property(nonatomic, strong, readonly) DebugToolsViewController *(^setup)(void);


@end

@implementation DebugToolsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}




- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"调试工具";
    self.navigationController.navigationBarHidden = YES;
    self.setup();
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- =======

- (DebugToolsViewController *(^)(void))setup {

    weakself
    DebugToolsViewController *(^setup)(void) = ^DebugToolsViewController *(void) {
        bself.title = @"酒仙网调试工具_V0.0.2";
        bself.navigationController.navigationBar.titleTextAttributes = @{};
        bself.navigationItem.hidesBackButton = YES;

        if (!bself.dataManage) {
            DebugDataManage *manager = [DebugDataManage manage];
            manager.source = [DataManagerSource new];
            bself.dataManage = manager;
            bself.dataManage.vc = self;
            
        }
        
        if (!bself.navBar) {
            bself.navBar = [UILabel new];
            [bself.view addSubview:bself.navBar];
            
            [bself.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view.mas_top).offset(5);
                make.right.mas_equalTo(self.view.mas_right);
                make.left.mas_equalTo(self.view.mas_left);
                make.height.mas_equalTo(64);
            }];
            bself.navBar.text = @"酒仙网调试工具_V0.0.2 -- sopig.cn ";
            bself.navBar.textAlignment = NSTextAlignmentCenter;
            bself.navBar.textColor = [UIColor orangeColor];

        }

        if (!bself.tableView) {
            bself.tableView = [UITableView new];
            [bself.view addSubview:bself.tableView];

            [bself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
            }];
        }

        bself.tableView.delegate = bself.dataManage;
        bself.tableView.dataSource = bself.dataManage;
        
        
        

        return bself;
    };

    return setup;
}

@end
