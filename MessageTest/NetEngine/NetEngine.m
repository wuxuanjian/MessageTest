//
//  NetEngine.m
//  MessageTest
//
//  Created by EinFachMann on 13-12-27.
//
//

#import "NetEngine.h"
#import "readSMSEngine.h"

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
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sendSucceedArr, @"parameter", nil];
    return [self postRequest:@"sendNumberSuccess/doAdd.h" params:dic onCompletion:responseblock onError:errorblock];
}

-(MKNetworkOperation*) sendNumberCompletion:(CBNetWorkComplete)responseblock onError:(CBNetWorkError)errorblock
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    return [self postRequest:@"sendNumber/findTask.h" params:dic onCompletion:responseblock onError:errorblock];
}

@end
