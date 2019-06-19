//
//  TYWCDBStartVC.m
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYWCDBStartVC.h"
#import "TYWCDBStartModel.h"
#import "TYDBservice.h"
#import "TYPerson+WCTTableCoding.h"

#define TY_TABLE_MESSAGE_NAME @"TY_TABLE_MESSAGE_NAME"
#define TY_TABLE_CONTENT_NAME @"TY_TABLE_CONTENT_NAME"

@interface TYWCDBStartVC ()

@property(nonatomic, strong) NSArray<TYWCDBStartModel *> * oprationArray;

@end

@implementation TYWCDBStartVC

static NSString * cellID = @"operationCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    _oprationArray = [self getDataFromPlist];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _oprationArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    TYWCDBStartModel * model = _oprationArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dataBaseActionWithModel:_oprationArray[indexPath.row]];
}


#pragma mark - database method
- (void)dataBaseActionWithModel:(TYWCDBStartModel *)model {
    NSString *tipString = @"";
    BOOL isSuccess = NO;
    TYDBService *service = [[TYDBService alloc] initWithTableName:TY_TABLE_MESSAGE_NAME class:TYPerson.class];
    switch ([model.select integerValue]) {
        case 0:// 添加单条数据
            {
                TYPerson *person = [[TYPerson alloc] init];
                person.name = @"Sheldon";
                person.age = 28;
                person.gender = TYUserGenderTypeMale;
                isSuccess = [service.operation insertObject:person into:TY_TABLE_MESSAGE_NAME];
                
                if (isSuccess) {
                    tipString = @"添加成功";
                } else {
                    tipString = @"添加失败";
                }
            }
            break;
        case 1:// 添加多条数据
        {
            NSString *personDataPath = [[NSBundle mainBundle] pathForResource:@"PersonData" ofType:@"plist"];
            NSArray *listArray = [NSArray arrayWithContentsOfFile:personDataPath];
            NSArray<TYPerson *> *personArray = [NSArray yy_modelArrayWithClass:TYPerson.class json:listArray];
            isSuccess = [service.operation insertObjects:personArray into:TY_TABLE_MESSAGE_NAME];
            
            if (isSuccess) {
                tipString = @"添加成功";
            } else {
                tipString = @"添加失败";
            }
            
        }
            break;
        case 2:// 修改单条数据
        {
            TYPerson *person = [[TYPerson alloc] init];
            person.name = @"Sheldon";
            person.age = 30;
            person.gender = TYUserGenderTypeMale;
            isSuccess = [service.operation.database updateRowsInTable:TY_TABLE_MESSAGE_NAME onProperty:TYPerson.age withObject:person where:TYPerson.localID==1];
            
            if (isSuccess) {
                tipString = @"修改成功";
            } else {
                tipString = @"修改失败";
            }
        }
            break;
        case 3:// 修改多条数据
        {
            TYPerson *person = [[TYPerson alloc] init];
            person.name = @"Sheldon";
            person.age = 30;
            person.gender = TYUserGenderTypeMale;
            isSuccess = [service.operation.database updateRowsInTable:TY_TABLE_MESSAGE_NAME onProperty:TYPerson.age withObject:person where:TYPerson.age > 70];
            if (isSuccess) {
                tipString = @"修改成功";
            } else {
                tipString = @"修改失败";
            }
        }
            break;
        case 4:// 删除单条数据
        {
            isSuccess = [service.operation.database deleteObjectsFromTable:TY_TABLE_MESSAGE_NAME where:TYPerson.localID==3];
            if (isSuccess) {
                tipString = @"删除成功";
            } else {
                tipString = @"删除失败";
            }
        }
            break;
        case 5:// 删除多条数据
        {
            isSuccess = [service.operation.database deleteObjectsFromTable:TY_TABLE_MESSAGE_NAME where:TYPerson.localID<5];
            if (isSuccess) {
                tipString = @"删除成功";
            } else {
                tipString = @"删除失败";
            }
        }
            break;
        default:
            break;
    }
    
    UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:tipString message:tipString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertCtr addAction:sureAction];
    [self presentViewController:alertCtr animated:YES completion:nil];
}

- (NSArray<TYWCDBStartModel *> *)getDataFromPlist {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TYWCDBStartVCData" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    NSArray<TYWCDBStartModel *> *dataArray = [NSArray yy_modelArrayWithClass:TYWCDBStartModel.class json:array];
    return dataArray;
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
