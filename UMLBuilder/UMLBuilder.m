//
//  UMLBuilder.m
//  UMLBuilder
//
//  Created by tianchi.shao on 13-9-6.
//  Copyright (c) 2013年 tianchi.shao. All rights reserved.
//


#define kPropertyRegex @"\\@property"
#define kPropertyNameRegex @"\\s[A-Za-z_\\*\\s]+;"
#define kPropertyTypeRegex @"(\\s|\\))[A-Za-z_]+(\\s|\\*)"

#define kActionRegex @"(-|\\+)(\\s|)\\([A-Za-z]+\\)(\\s|)[A-Za-z_\\*\\s\\:\\(\\)]+"
#define kActionNameRegex @"(-|\\+)(\\w|\\W)+(\\:|)"
#define kActionRelpaceRegex @"\\:\\([A-Za-z_]+(\\s|)(\\*|)\\)[A-Za-z_]+"

#define kClassNameRegex @"\\@(interface(\\s|)[A-Za-z_]+|implementation[A-Za-z_\\s]+)"

#import "UMLBuilder.h"
#import "ClassModel.h"
#import "RegexKitLite.h"

@interface UMLBuilder()
@property (strong,nonatomic) NSArray *contentArr;
@property (strong,nonatomic) NSString *filePath;
@property (assign, nonatomic) dispatch_queue_t buildQueue;
@end

@implementation UMLBuilder
static UMLBuilder *instance;

+(id)SharedUMLBuilder:(NSArray *)arr andPath:(NSString *)path{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[UMLBuilder alloc] initWithContentArr:arr andPath:path];
    });
    return instance;
}

+(id)SharedUMLBuilder{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[UMLBuilder alloc] initWithContentArr:nil andPath:nil];
    });
    return instance;
}


-(id)initWithContentArr:(NSArray *)arr andPath:(NSString *)path{
    self = [super init];
    if (self) {
        _contentArr=arr;
        _filePath=path;
        _buildQueue = dispatch_queue_create("UMLBuilder", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(void)startBuild{
    if (_contentArr==nil||_filePath==nil||_contentArr.count==0||[_filePath isEqualToString:@""]) {
        return;
    }
    dispatch_async(_buildQueue, ^{
        for (NSString *fileName in _contentArr) {
            NSString *path_h=[_filePath stringByAppendingFormat:@"/%@.h",fileName];
            NSString *path_m=[_filePath stringByAppendingFormat:@"/%@.m",fileName];
            
            ClassModel *model_h = [self getInfoWithPath:path_h];
            ClassModel *model_m = [self getInfoWithPath:path_m];
            ClassModel *mergeredModel = [model_h mergerAnotherModel:model_m];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyName object:mergeredModel];
        }
    });
}

-(ClassModel *)getInfoWithPath:(NSString *)path{
    //容器初始化
    ClassModel *classModel=[[ClassModel alloc] init];
    NSMutableArray *propertyArr=[[NSMutableArray alloc] init];
    NSMutableArray *actionArr=[[NSMutableArray alloc] init];
    //读取内容
    NSString *content=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //读取每一行
    NSArray *lineArr=[content componentsSeparatedByString:@"\n"];
    
    NSMutableString *notEndLine=[[NSMutableString alloc] init];
    for (int i=0;i<lineArr.count;i++) {
        NSString *line=[lineArr objectAtIndex:i];
        
        BOOL isClassName=[line isMatchedByRegex:kClassNameRegex];
        if (isClassName){
            NSString *matchName=[line stringByMatching:kClassNameRegex];
            if ([matchName rangeOfString:@"@interface"].location!=NSNotFound) {
                classModel.className=[[matchName componentsSeparatedByString:@"@interface"] objectAtIndex:1];
            }else if([matchName rangeOfString:@"@implementation"].location!=NSNotFound){
                classModel.className=[[matchName componentsSeparatedByString:@"@implementation"] objectAtIndex:1];
            }
        }else{
            if ([line rangeOfString:@";"].location==NSNotFound && [line rangeOfString:@"{"].location==NSNotFound) {
                [notEndLine appendString:line];
            }else{
                [notEndLine appendString:line];
                line=notEndLine;
                BOOL isProperty = [line isMatchedByRegex:kPropertyRegex];
                BOOL isAction = [line isMatchedByRegex:kActionRegex];
                if (isProperty) {
                    NSString *propertyName=[line stringByMatching:kPropertyNameRegex];
                    [propertyArr addObject:propertyName];
                }else if(isAction){
                    NSString *actionName = [[line stringByMatching:kActionRegex] stringByReplacingOccurrencesOfRegex:kActionRelpaceRegex withString:@":"];
                    [actionArr addObject:actionName];
                }
                [notEndLine setString:@""];
            }
        }
    }
    classModel.propertyArr=propertyArr;
    classModel.actionArr=actionArr;
    return classModel;
}


-(ClassModel *)getRelation:(ClassModel *)model andPath:(NSString *)path{
    //容器初始化
    ClassModel *classModel=model;
    NSMutableArray *compositionArr=[[NSMutableArray alloc] init];
    NSMutableArray *aggregationArr=[[NSMutableArray alloc] init];
    
    //读取内容
    NSString *content=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    for (NSString *property in model.propertyArr) {
        
    }
}

@end
