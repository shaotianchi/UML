//
//  UMLViewController.m
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import "UMLViewController.h"
#import "BaseUMLFrame.h"
#import "ListView.h"
#import "ClassModel.h"

@interface UMLViewController ()
@property (assign,nonatomic) BOOL isOpen;
@property (assign,nonatomic) CGRect befroFrame;
@property (assign,nonatomic) NSInteger count;

@property (assign,nonatomic) CGPoint befroePoint;
@end

@implementation UMLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect frame=self.contentView.frame;
    frame.size.height=10000;
    frame.size.width=10000;
    self.contentView.frame=frame;
    //[_contentScrollView setContentSize:CGSizeMake(1000, 1000)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:kNotifyName object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotifyName object:nil];
}

-(void)receiveNotification:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame=CGRectZero;
        frame.origin.x=169*(_count%3);
        frame.origin.y=171*(_count/3)+44;
        frame.size.width=159;
        frame.size.height=71;
        ClassModel *model=(ClassModel *)notification.object;
        BaseUMLFrame *umlFrame=[[[NSBundle mainBundle] loadNibNamed:@"UMLFrameView" owner:self options:nil] objectAtIndex:0];
        umlFrame.titleLb.text=model.className;
        umlFrame.frame=frame;
        umlFrame.properyArr=model.propertyArr;
        umlFrame.actionArr=model.actionArr;
        [self.contentView addSubview:umlFrame];
        _count++;
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn_Clicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *array=[touches allObjects];
    CGPoint jd=[[array objectAtIndex:0] locationInView:self.view];
    _befroePoint=jd;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *array=[touches allObjects];
    CGPoint jd=[[array objectAtIndex:0] locationInView:self.view];
    CGRect frame=self.contentView.frame;
    frame.origin.x=frame.origin.x+jd.x-_befroePoint.x;
    frame.origin.y=frame.origin.y+jd.y-_befroePoint.y;
    self.contentView.frame=frame;
    _befroePoint=jd;
}
@end
