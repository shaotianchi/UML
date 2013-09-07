//
//  BaseUMLFrame.m
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import "BaseUMLFrame.h"
#import "ListView.h"
@interface BaseUMLFrame()
@property (assign,nonatomic) BOOL isProperyOpen;
@property (assign,nonatomic) BOOL isActionOpen;

@property (assign,nonatomic) CGPoint beforePoint;
@end

@implementation BaseUMLFrame

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _isOpen=YES;
    _isProperyOpen=NO;
    _isActionOpen=NO;
}

- (IBAction)titleBtn_Clicked:(id)sender {
    if (_isOpen) {
        _isOpen=NO;
        //close
    }else{
        _isOpen=YES;
        //open
    }
}

- (IBAction)propertyBtn_Clicked:(id)sender {
    if (_isProperyOpen) {
        _isProperyOpen=NO;
        //close propery list
        _propertyView.alpha=0;
        [_propertyView removeFromSuperview];
        CGRect frame=_actionBtn.frame;
        frame.origin.y=_propertyBtn.frame.origin.y+_propertyBtn.frame.size.height;
        [_actionBtn setFrame:frame];
        if (_actionView.alpha==1) {
            CGRect actionFrame=_actionView.frame;
            actionFrame.origin.y=_actionBtn.frame.origin.y+_actionBtn.frame.size.height;
            _actionView.frame=actionFrame;
        }
    }else{
        if (_properyArr==nil||_properyArr.count==0) {
            return;
        }
        _isProperyOpen=YES;
        
        ListView *newPropertyView=[[ListView alloc] initWithArray:_properyArr];
        _propertyView=newPropertyView;
        
        CGRect frame=_propertyView.frame;
        frame.origin.y=_propertyBtn.frame.origin.y+_propertyBtn.frame.size.height;
        _propertyView.frame=frame;
        
        _propertyView.alpha=1;
        [_propertyView setBackgroundColor:[UIColor redColor]];
        [self addSubview:_propertyView];
        CGRect aFrame=_actionBtn.frame;
        aFrame.origin.y=_propertyView.frame.origin.y+_propertyView.frame.size.height;
        [_actionBtn setFrame:aFrame];
        if (_actionView.alpha==1) {
            CGRect actionFrame=_actionView.frame;
            actionFrame.origin.y=_actionBtn.frame.origin.y+_actionBtn.frame.size.height;
            _actionView.frame=actionFrame;
        }
    }
    [self changeViewFrame];
}

-(void)changeViewFrame{
    CGRect viewFrame=self.frame;
    
    viewFrame.size.height=_propertyBtn.frame.origin.y+_propertyBtn.frame.size.height+_actionBtn.frame.size.height+_propertyView.frame.size.height*_propertyView.alpha+_actionView.frame.size.height*_actionView.alpha;
    self.frame=viewFrame;
    
}

- (IBAction)actionsBtn_Clicked:(id)sender {
    if (_isActionOpen) {
        _isActionOpen=NO;
        //close
        _actionView.alpha=0;
        [_actionView removeFromSuperview];
    }else{
        if (_actionArr==nil||_actionArr.count==0) {
            return;
        }
        _isActionOpen=YES;
        ListView *newPropertyView=[[ListView alloc] initWithArray:_actionArr];
        _actionView=newPropertyView;
        [_actionView setBackgroundColor:[UIColor redColor]];
        _actionView.alpha=1;
        CGRect frame=_actionView.frame;
        frame.origin.y=_actionBtn.frame.origin.y+_actionBtn.frame.size.height;
        _actionView.frame=frame;
        [self addSubview:_actionView];
    }
    [self changeViewFrame];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.superview bringSubviewToFront:self];
    NSArray *array=[touches allObjects];
    CGPoint jd=[[array objectAtIndex:0] locationInView:self.superview];
    _beforePoint=jd;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *array=[touches allObjects];
    CGPoint jd=[[array objectAtIndex:0] locationInView:self.superview];
    CGPoint center=self.center;
    center.x=center.x+jd.x-_beforePoint.x;
    center.y=center.y+jd.y-_beforePoint.y;
    
    if (center.x<0||center.x>self.superview.frame.size.width||center.y<0||center.y>self.superview.frame.size.height) {
        return;
    }
    self.center=center;
    _beforePoint=jd;
}

@end
