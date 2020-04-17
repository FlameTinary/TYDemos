//
//  TYDatabaseInfoVC.m
//  TYWCDBDemo
//
//  Created by 田宇 on 2020/4/17.
//  Copyright © 2020 Sheldon. All rights reserved.
//

#import "TYDatabaseInfoVC.h"
#import <WCDB/WCDB.h>
#import "Masonry.h"

@interface TYDatabaseInfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView * tableView;
@end

@implementation TYDatabaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    NSLog(@"%@",self.databasePath);
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableCellID"];
    cell.textLabel.text = @"22";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"tableCellID"];
    }
    return _tableView;
}

@end
