//
//  ClassModel.h
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-6.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject
@property (strong,nonatomic) NSString *className;
//参数
@property (strong,nonatomic) NSMutableArray *propertyArr;
//方法
@property (strong,nonatomic) NSMutableArray *actionArr;
//父类
@property (strong,nonatomic) NSString *superClassName;
//依赖关系
@property (strong,nonatomic) NSMutableArray *dependArr;
//组合关系
@property (strong,nonatomic) NSMutableArray *compositionArr;
//聚合关系
@property (strong,nonatomic) NSMutableArray *aggregationArr;

//合并两个Model
-(ClassModel *)mergerAnotherModel:(ClassModel *)model;
@end
