//
//  TYPerson.h
//  TYDemos
//
//  Created by 田宇 on 2019/6/15.
//  Copyright © 2019 Sheldon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TYUserGenderType){
    TYUserGenderTypeNone = 0,    //未知
    TYUserGenderTypeMale = 1,    //男
    TYUserGenderTypeFemale = 2,  //女
};

@interface TYPerson : NSObject

@property(nonatomic, assign) NSInteger localID;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, strong) NSDate *createDate;
@property(nonatomic, assign) TYUserGenderType gender;

@end
