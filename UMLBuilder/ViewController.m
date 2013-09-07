//
//  ViewController.m
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-5.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//

#import "ViewController.h"
#import "RegexKitLite.h"
#import "UMLViewController.h"
#import "UMLBuilder.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSString *filePath;

@property (strong,nonatomic) NSArray *filesArr;
@property (strong,nonatomic) NSMutableArray *buildFilesArr;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _filesTableView.delegate    = self;
    _filesTableView.dataSource  = self;
    
    _buildFilesArr = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseBtn_Clicked:(id)sender {
    NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/classes"];
    _filePath=path;
    _filesArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in _filesArr) {
        if ([fileName rangeOfString:@"."].location!=NSNotFound) {
            if ([[[fileName componentsSeparatedByString:@"."] objectAtIndex:1] isEqualToString:@"h"]) {
                [_buildFilesArr addObject:[[fileName componentsSeparatedByString:@"."] objectAtIndex:0]];
            }
        }
    }
    [_filesTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _filesArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"FileNameCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[_filesArr objectAtIndex:indexPath.row];
    if ([cell.textLabel.text rangeOfString:@"."].location==NSNotFound) {
        [cell.imageView setImage:[UIImage imageNamed:@"check_normal"]];
    }else{
        if ([[[cell.textLabel.text componentsSeparatedByString:@"."] objectAtIndex:1] isEqualToString:@"m"] ||
            [[[cell.textLabel.text componentsSeparatedByString:@"."] objectAtIndex:1] isEqualToString:@"h"]) {
            [cell.imageView setImage:[UIImage imageNamed:@"check_selected"]];
        }else{
            [cell.imageView setImage:[UIImage imageNamed:@"check_normal"]];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [[UMLBuilder SharedUMLBuilder:_buildFilesArr andPath:_filePath] startBuild];
}
@end
