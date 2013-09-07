//
//  UMLViewController.h
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMLViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)backBtn_Clicked:(id)sender;
@property (strong,nonatomic) NSArray *pArr;
@property (strong,nonatomic) NSArray *aArr;
@end
