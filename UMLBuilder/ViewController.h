//
//  ViewController.h
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)chooseBtn_Clicked:(id)sender;
- (IBAction)startBtn_Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *filesTableView;

@end
