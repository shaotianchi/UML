//
//  ListView.h
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListView : UIView
-(BOOL)isHaveContent;
-(CGFloat)getBelowOriginY;
-(id)initWithArray:(NSArray *)arr;
@end
