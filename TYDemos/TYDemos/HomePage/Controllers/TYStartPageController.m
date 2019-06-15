//
//  TYStartPageController.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/6.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYStartPageController.h"
#import "TYHomeDataModel.h"

@interface TYStartPageController ()

@property(nonatomic, strong) NSArray<TYHomeDataModel *> * dataModelArray;

@end

@implementation TYStartPageController

static NSString * cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataModelArray = [self getDataFromPlist];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    TYHomeDataModel *model = _dataModelArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.desc;
    return cell;
}

- (NSArray<TYHomeDataModel *> *)getDataFromPlist {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"HomePageData" ofType:@"plist"];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:plistPath];
    NSArray<TYHomeDataModel *> * dataModelArr = [NSArray yy_modelArrayWithClass:TYHomeDataModel.class json:dataArr];
    return dataModelArr;
}
@end
