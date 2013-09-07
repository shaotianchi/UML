//
//  ListView.m
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import "ListView.h"

@interface ListView()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSArray *contentArr;
@property (strong,nonatomic) UITableView *contentTableView;
@end

@implementation ListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithArray:(NSArray *)arr{
    self=[super init];
    if (self) {
        _contentArr=arr;
        _contentTableView=[[UITableView alloc] init];
        _contentTableView.delegate=self;
        _contentTableView.dataSource=self;
        _contentTableView.backgroundColor=[UIColor clearColor];
        CGRect frame=CGRectMake(0, 0, 159, _contentArr.count>5?5*22:22*_contentArr.count);
        self.frame=frame;
        _contentTableView.frame=frame;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (![self.subviews containsObject:_contentTableView]) {
        [self addSubview:_contentTableView];
    }
    [_contentTableView reloadData];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
//    [_contentTableView setFrame:frame];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contentArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 22;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"ContentCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[_contentArr objectAtIndex:indexPath.row];//[NSString stringWithFormat:@".   %@",[_contentArr objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.numberOfLines=0;
    cell.textLabel.lineBreakMode=NSLineBreakByCharWrapping;
    cell.textLabel.font=[UIFont systemFontOfSize:9];
}

-(BOOL)isHaveContent{
    return _contentArr.count==0?NO:YES;
}

-(CGFloat)getBelowOriginY{
    return self.frame.origin.y+self.frame.size.height;
}

@end
