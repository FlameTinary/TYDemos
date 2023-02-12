//
//  ViewController.m
//  TYWCDBDemo
//
//  Created by Sheldon on 2019/7/30.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "ViewController.h"
#import <WCDB/WCDB.h>
#import "Masonry.h"
#import "TYNoInfoView.h"
#import "TeacherModel.h"
#import "TYDatabaseInfoVC.h"

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) NSArray<NSString *> * databaseArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // 查询路径下是否有数据库,有则列出
    NSString* path = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"rootDBPath"];
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if (![fm fileExistsAtPath:path isDirectory:&isDirectory] || !isDirectory || [fm subpathsAtPath:path].count == 0) {
        TYNoInfoView * noinfoView = [[TYNoInfoView alloc] init];
        noinfoView.text = @"没有数据库";
        noinfoView.actionText = @"创建数据库";
        noinfoView.actionCallback = ^{
            [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            NSString *dbPath = path;
            dbPath = [dbPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",@"test"]];
            WCTDatabase * db = [[WCTDatabase alloc] initWithPath:dbPath];
            [db createTableAndIndexesOfName:@"teacherTable" withClass:TeacherModel.class];
            [self reloadController];
        };
        [self.view addSubview:noinfoView];
        [noinfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    } else {
        NSMutableArray * databaseArr = [NSMutableArray array];
        NSArray *subPaths = [fm subpathsAtPath:path];
        for (NSString *path in subPaths) {
            if ([path hasSuffix:@".db"]) {
                [databaseArr addObject:path];
            }
        }
        self.databaseArray = databaseArr.copy;
        [self.tableView reloadData];
    }
    
}

- (void)reloadController {
    NSArray * subViews = [self.view subviews];
    if (subViews.count > 0) {
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
    }
    [self viewWillDisappear:YES];
    [self viewDidDisappear:YES];
    [self viewDidLoad];
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];
    [self viewWillLayoutSubviews];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TYDatabaseCellID"];
    NSString *dbName = self.databaseArray[indexPath.row];
    cell.textLabel.text = dbName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* path = [PATH_OF_DOCUMENT stringByAppendingPathComponent:@"rootDBPath"];
    NSString *dbName = self.databaseArray[indexPath.row];
    path = [path stringByAppendingPathComponent:dbName];
    TYDatabaseInfoVC * databaseInfoVC = [[TYDatabaseInfoVC alloc] init];
    databaseInfoVC.databasePath = path;
    [self.navigationController pushViewController:databaseInfoVC animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.databaseArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"数据库名称";
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TYDatabaseCellID"];
    }
    return _tableView;
}
@end
