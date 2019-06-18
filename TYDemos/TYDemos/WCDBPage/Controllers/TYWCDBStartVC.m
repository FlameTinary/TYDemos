//
//  TYWCDBStartVC.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYWCDBStartVC.h"

#define TY_TABLE_CONTENT_NAME @"TY_TABLE_CONTENT_NAME"

@interface TYWCDBStartVC ()

@property(nonatomic, strong) NSArray * oprationArray;

@end

@implementation TYWCDBStartVC

static NSString * cellID = @"operationCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    _oprationArray = @[@"创建数据库", @"创建表", @"添加单条数据", @"添加多条数据", @"修改单条数据", @"修改多条数据", @"删除单条数据", @"删除多条数据"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _oprationArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = _oprationArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL sel = NSSelectorFromString(@"createDataBase");
    
    IMP imp = [self methodForSelector:sel];
    
    void(*func)(id, SEL) = (void *)imp;
    
    func(self, sel);
    
    
//    if ([self respondsToSelector:sel]) {
//        [self performSelector:sel];
//    }
}


- (void)createDataBase {
    NSLog(@"点击了createDataBase方法");
}

- (void)createTable {
    
}

- (void)addSingleData {
    
}

- (void)addDataWithArray {
    
}

- (void)updateSingleData {
    
}

- (void)updateDataWithArray {
    
}

- (void)deleteSingleData {
    
}

- (void)deleteDataWithArray {
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
