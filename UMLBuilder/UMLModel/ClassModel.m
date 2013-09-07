//
//  ClassModel.m
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-6.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel

-(id)init{
    self=[super init];
    if (self) {
        _propertyArr=[[NSMutableArray alloc] init];
        _actionArr=[[NSMutableArray alloc] init];
    }
    return self;
}

-(ClassModel *)mergerAnotherModel:(ClassModel *)model{
    if ([self.className isEqualToString:model.className]) {
        for (NSString *property in model.propertyArr) {
            if (![self.propertyArr containsObject:property]) {
                [self.propertyArr addObject:property];
            }
        }
        for (NSString *action in model.actionArr) {
            if(![self.actionArr containsObject:action]){
                [self.actionArr addObject:action];
            }
        }
        return self;
    }else{
        return nil;
    }
}
@end
