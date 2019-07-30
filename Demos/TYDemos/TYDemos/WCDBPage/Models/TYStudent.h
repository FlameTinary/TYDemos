//
//  TYStudent.h
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import "TYPerson.h"

@interface TYStudent : TYPerson

@property(nonatomic, assign) float totalScore;
@property(nonatomic, copy) NSString * job;
@property(nonatomic, strong) NSNumber * stature;
@property(nonatomic, assign) NSTimeInterval timer;
@property(nonatomic, strong) NSDictionary * testDic;

@end
