//
//  readSMSEngine.m
//  MessageTest
//
//  Created by EinFachMann on 13-12-18.
//
//

#import "readSMSEngine.h"
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMResultSet.h"


@implementation readSMSEngine

+(NSArray*)readMessageId
{
    
    NSString *dbPath = @"/var/mobile/Library/SMS/sms.db";
    
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:dbPath]) //如果不存在
    {
        return nil;
    }
    
    NSMutableArray* idArray = [[NSMutableArray alloc] initWithCapacity:3];
    FMDatabase* database = [ FMDatabase databaseWithPath: dbPath ];
    
    if ( ![ database open ] )
    {
        return nil;
    }
    
    // 查找表 AllTheQustions
    FMResultSet* resultSet = [ database executeQuery: @"select * from message" ];
    
    // 逐行读取数据
    while ( [ resultSet next ] )
    {
        // 对应字段来取数据
        NSString* phone = [ resultSet stringForColumn: @"madrid_handle" ];
        NSString* madridFlags = [ resultSet stringForColumn: @"madrid_flags" ];
        
        NSString *bphone = phone;
        if([phone hasPrefix:@"+86"])
        {
            bphone = [phone substringFromIndex:3];
        }
        
        if(![madridFlags isEqualToString:@"5"])
        {
            NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:bphone,@"phoneNumber"
                                 ,@"yes",@"status"
                                 ,nil];
            [idArray addObject:dic];
        }
        else
        {
            NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:bphone,@"phoneNumber"
                                 ,@"no",@"status"
                                 ,nil];
            [idArray addObject:dic];
        }
    }
    [ database close];
    return idArray;
}

+(void) removeDBFile
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //删除sms.db
    NSString *dbPath = @"/var/mobile/Library/SMS/sms.db";
    if(![fileManager fileExistsAtPath:dbPath]) //如果不存在
    {
        return;
    }
    [fileManager removeItemAtPath:dbPath error:nil];
    
    //删除sms.db-shm
    NSString *dbPath1 = @"/var/mobile/Library/SMS/sms.db-shm";
    [fileManager removeItemAtPath:dbPath1 error:nil];
    
    //删除sms.db-wal
    NSString *dbPath11 = @"/var/mobile/Library/SMS/sms.db-wal";
    [fileManager removeItemAtPath:dbPath11 error:nil];
    
}


@end
