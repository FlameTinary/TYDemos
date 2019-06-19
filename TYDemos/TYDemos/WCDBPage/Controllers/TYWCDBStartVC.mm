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
    TYDBService *service = [[TYDBService alloc] initWithTableName:TY_TABLE_MESSAGE_NAME class:TYPerson.class];
    switch ([model.select integerValue]) {
        case 0:
            {
                TYPerson *person = [[TYPerson alloc] init];
                person.name = @"Sheldon";
                person.age = 28;
                person.gender = TYUserGenderTypeMale;
                [service.operation insertObject:person into:TY_TABLE_MESSAGE_NAME];
            }
            break;
        case 1:
        {
            NSString *personDataPath = [[NSBundle mainBundle] pathForResource:@"PersonData" ofType:@"plist"];
            NSArray *listArray = [NSArray arrayWithContentsOfFile:personDataPath];
            NSArray<TYPerson *> *personArray = [NSArray yy_modelArrayWithClass:TYPerson.class json:listArray];
            [service.operation insertObjects:personArray into:TY_TABLE_MESSAGE_NAME];
        }
            break;
        case 2:
        {
            TYPerson *person = [[TYPerson alloc] init];
            person.name = @"Sheldon";
            person.age = 30;
            person.gender = TYUserGenderTypeMale;
            //[service.operation.database updateRowsInTable:TY_TABLE_MESSAGE_NAME onProperty:TYPerson.age withObject:person where:<#(const WCTCondition &)#>];
        }
            break;
        default:
            break;
    }
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
