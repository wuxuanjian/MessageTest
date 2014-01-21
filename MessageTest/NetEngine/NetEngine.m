//
//  NetEngine.m
//  MessageTest
//
//  Created by EinFachMann on 13-12-27.
//
//

#import "NetEngine.h"
#import "readSMSEngine.h"
#import "JSONKit.h"

static NetEngine* postEngine = nil;
@implementation NetEngine

+(NetEngine*) postEngineShare
{
    if (postEngine == nil)
    {
        postEngine = [[NetEngine alloc] initWithHostName:@"140.207.213.17:8093/iosService" customHeaderFields:nil];
    }
    return postEngine;
}

-(MKNetworkOperation*) postRequest:(NSString*)reqPort params:(NSMutableDictionary*)body onCompletion:(CBNetWorkComplete)responseblock onError:(CBNetWorkError)errorblock
{
    MKNetworkOperation *op = [self operationWithPath:reqPort
                                              params:body
                                          httpMethod:@"POST"];
    //[op setUsername:@"bobs@thga.me" password:@"12345678"];
    [op onCompletion:^(MKNetworkOperation *operation)
     {
         NSString* responseStr = operation.responseString;
         DLog(@"%@", responseStr);
         responseblock(responseStr);
     }
    onError:^(NSError *error)
     {
         DLog(@"%@", error);
         errorblock(error);
     }];
    [self enqueueOperation:op];
    return op;
}

-(MKNetworkOperation*) doAddOnCompletion:(CBNetWorkComplete)responseblock onError:(CBNetWorkError)errorblock
{
    NSArray* sendSucceedArr = [readSMSEngine readMessageId];
    NSString* phonestr = [sendSucceedArr JSONString];
    [NetEngine writestring:phonestr];
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:phonestr, @"parameter", nil];
    return [self postRequest:@"sendNumberSuccess/doAdd.h" params:dic onCompletion:responseblock onError:errorblock];
    
}

-(MKNetworkOperation*) sendNumberCompletion:(CBNetWorkComplete)responseblock onError:(CBNetWorkError)errorblock
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    return [self postRequest:@"sendNumber/findTask.h" params:dic onCompletion:responseblock onError:errorblock];
}



//写文件
+(void) writestring:(NSString*)str
{
    [NetEngine appString:str];
}

+(void) appString:(NSString*)str
{
    NSString* dbPath = @"/var/mobile/Library/SMS/Log.txt";
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:dbPath])
    {
        [fileManager createFileAtPath:dbPath contents:nil attributes:nil];
    }
    
    NSFileHandle  *outFile;
    NSData *buffer;
    
    outFile = [NSFileHandle fileHandleForWritingAtPath:dbPath];
    
    if(outFile == nil)
    {
        NSLog(@"Open of file for writing failed");
    }
    
    NSDate *today = [NSDate date];
    NSDateFormatter *formmat = [[NSDateFormatter alloc] init];
    [formmat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [formmat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formmat setTimeZone:[NSTimeZone defaultTimeZone]];
    NSString*timeStr = [formmat stringFromDate:today];
    
    
    //找到并定位到outFile的末尾位置(在此后追加文件)
    [outFile seekToEndOfFile];
    
    //读取inFile并且将其内容写到outFile中
    NSString *bs = [NSString stringWithFormat:@"\n[%@]  %@",timeStr,str];
    buffer = [bs dataUsingEncoding:NSUTF8StringEncoding];
    
    [outFile writeData:buffer];
    
    //关闭读写文件
    [outFile closeFile];
    
}



@end
