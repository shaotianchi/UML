//
//  UMLBuilder.h
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-6.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMLBuilder : NSObject
+(id)SharedUMLBuilder:(NSArray *)arr andPath:(NSString *)path;
+(id)SharedUMLBuilder;
-(id)initWithContentArr:(NSArray *)arr andPath:(NSString *)path;
-(void)startBuild;
@end
