//
//  BaseUMLFrame.h
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListView;
@interface BaseUMLFrame : UIView
@property (weak, nonatomic) IBOutlet UIButton *propertyBtn;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
- (IBAction)titleBtn_Clicked:(id)sender;
- (IBAction)propertyBtn_Clicked:(id)sender;
- (IBAction)actionsBtn_Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) ListView *propertyView;
@property (weak, nonatomic) ListView *actionView;

@property (assign,nonatomic) BOOL isOpen;


@property (strong,nonatomic) NSArray *properyArr;
@property (strong,nonatomic) NSArray *actionArr;
@end
