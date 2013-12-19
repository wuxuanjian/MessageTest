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
        if(![madridFlags isEqualToString:@"5"])
        {
            [idArray addObject:phone];
        }
    }
    
    [ database close];
//    if([idArray count] > 0)
//    {
//        NSString* showStr = [NSString stringWithFormat:@"madrid_handle=%@",[idArray objectAtIndex:0]];
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:showStr delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
//        [alert show];
//    }

    
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
