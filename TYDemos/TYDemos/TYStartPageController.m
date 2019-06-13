//
//  TYStartPageController.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/6.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYStartPageController.h"

@interface TYStartPageController ()

@property(nonatomic, strong) NSArray * demos;

@end

@implementation TYStartPageController

static NSString * cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _demos = @[];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _demos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld", indexPath.row];
    return cell;
}

@end
