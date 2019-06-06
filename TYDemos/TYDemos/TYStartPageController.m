//
//  TYStartPageController.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/6.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYStartPageController.h"

@interface TYStartPageController ()

@end

@implementation TYStartPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld", indexPath.row];
    return cell;
}

@end
