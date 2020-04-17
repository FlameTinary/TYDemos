//
//  TeacherModel.h
//  wcdbTest
//
//  Created by 田宇 on 2020/1/19.
//  Copyright © 2020 sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherModel : NSObject

@property(nonatomic, strong) NSString * _id;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) float height;

@end
