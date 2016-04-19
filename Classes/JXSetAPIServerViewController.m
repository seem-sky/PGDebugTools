//
//  JXSetAPIServerViewController.m
//  jiuxian
//
//  Created by 张正超 on 15/12/4.
//  Copyright © 2015年 jiuxian.com. All rights reserved.
//

#import "JXSetAPIServerViewController.h"
#import "Masonry.h"

#define weakself typeof(self) __weak bself = self;

@interface JXSetAPIServerViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong, readonly) JXSetAPIServerViewController *(^setup)(void);

@end

@implementation JXSetAPIServerViewController


//- (NSMutableArray *)source {
//    if (!_source) {
//        _source = [NSMutableArray arrayWithArray:@[[[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_115],
//                [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_116],
//                [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_GRAY],
//                [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_ONLINE],
//                [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_TEST],
//                [[JXAppConfigSurport surport] getServerWithType:JXAPISERVICE_reserve]
//        ]];
//    }
//    return _source;
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.setup();

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- =======

- (JXSetAPIServerViewController *(^)(void))setup {

    weakself
    JXSetAPIServerViewController *(^setup)(void) = ^JXSetAPIServerViewController *(void) {
        bself.title = @"选择服务器地址";
        bself.navigationController.navigationBar.titleTextAttributes = @{};
        bself.navigationItem.hidesBackButton = YES;


        if (!bself.tableView) {
            bself.tableView = [UITableView new];
            [bself.view addSubview:bself.tableView];

            [bself.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
            }];

            bself.tableView.dataSource = bself;
            bself.tableView.delegate = bself;
        }

        return bself;
    };

    return setup;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *idf = @"com.debugManage.idf";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
    }
    if (indexPath.row <= ([self.source APIServiceSource].count -1)) {
     cell.textLabel.text = [self.source APIServiceSource][indexPath.row][@"JXBASE_URL_HOME"];
    }
   
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:HOSTDOMAIN] integerValue] == indexPath.row) {
        cell.textLabel.textColor = [UIColor redColor];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;

    [[NSUserDefaults standardUserDefaults] setValue:@(row) forKey:HOSTDOMAIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source APIServiceSource].count;
}


@end
