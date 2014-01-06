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

static NSUInteger dbitme = 0;
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
    NSString* itemstr = [NSString stringWithFormat:@"%d",dbitme];
    FMResultSet* resultSet = [database executeQuery: @"select * from message where ROWID > ?",itemstr];
    
    // 逐行读取数据
    while ( [ resultSet next ] )
    {
        // 对应字段来取数据
        NSString* phone = [ resultSet stringForColumn: @"madrid_handle" ];
//        NSString* madridFlags = [ resultSet stringForColumn: @"madrid_flags" ];
        NSString* madriderror = [ resultSet stringForColumn: @"madrid_error" ];
        NSString *bphone = phone;
        if([phone hasPrefix:@"+86"])
        {
            bphone = [phone substringFromIndex:3];
        }
        
        if([madriderror isEqualToString:@"0"])
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
    if([idArray count] > 0)
    {
        dbitme += [idArray count];
    }
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
    
//    NSString *dbPath = @"/var/mobile/Library/SMS/sms.db";
//    //创建文件管理器
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:dbPath]) //如果不存在
//    {
//        return;
//    }
//    FMDatabase* database = [ FMDatabase databaseWithPath: dbPath ];
//    if ( ![ database open ] )
//    {
//        return;
//    }
//    
//    [database executeUpdate:[readSMSEngine dropmessageDBSql],nil];
//    
//    [database executeUpdate:[readSMSEngine createmessageDBSql],nil];
//    
//    [ database close];
    
}

// 创建用户表
+(NSString *) createmessageDBSql
{
    NSString *sql = @" \n"
    "    CREATE TABLE [message] \n"                                
    "    ( \n"
    "       [ROWID] INTEGER PRIMARY KEY,  \n"
    "       [address] TEXT NOT NULL DEFAULT NULL,   \n"               
    "       [date] INTEGER NOT NULL DEFAULT NULL, \n"         
    "       [text] TEXT NOT NULL DEFAULT NULL, \n"
    "       [flags] INTEGER NOT NULL DEFAULT NULL,   \n"
    "       [replace] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [svc_center] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [group_id] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [association_id] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [height] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [UIFlags] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [version] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [subject] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [country] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [headers] BLOB NOT NULL DEFAULT NULL,  \n"
    "       [recipients] BLOB NOT NULL DEFAULT NULL,  \n"
    "       [read] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [madrid_attributedBody] BLOB NOT NULL DEFAULT NULL,  \n"
    "       [madrid_handle] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [madrid_version] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [madrid_guid] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [madrid_type] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [madrid_roomname] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [madrid_service] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [madrid_account] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [madrid_account_guid] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [madrid_flags] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [madrid_attachmentInfo] BLOB NOT NULL DEFAULT NULL,  \n"
    "       [madrid_url] TEXT NOT NULL DEFAULT NULL,  \n"
    "       [madrid_error] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [is_madrid] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [madrid_date_read] INTEGER NOT NULL DEFAULT NULL,  \n"
    "       [madrid_date_delivered] INTEGER NOT NULL DEFAULT NULL  \n"
    "    ); \n"
    ;
    
    return sql;
}

+(NSString *) dropmessageDBSql
{
    NSString *sql = @" \n"
    "    DROP TABLE IF EXISTS [message];  \n";
    return sql;
}

@end
