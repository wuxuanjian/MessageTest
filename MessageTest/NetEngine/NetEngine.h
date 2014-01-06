//
//  NetEngine.h
//  MessageTest
//
//  Created by EinFachMann on 13-12-27.
//
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

typedef void (^CBNetWorkComplete)(NSString* responseString);
typedef void (^CBNetWorkError)(NSError* err);
@interface NetEngine : MKNetworkEngine

+(NetEngine*) postEngineShare;

-(MKNetworkOperation*) doAddOnCompletion:(CBNetWorkComplete)responseblock onError:(CBNetWorkError)errorblock;

-(MKNetworkOperation*) sendNumberCompletion:(CBNetWorkComplete)responseblock onError:(CBNetWorkError)errorblock;

//写文件
+(void) writestring:(NSString*)str;

@end
