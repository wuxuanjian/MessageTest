//
//  msmholle.h
//  hollewordwoo
//
//  Created by EinFachMann on 13-12-6.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    
    ONE_SEND_MODEL_TYPE = 11111,   //如 186
    TWO_SEND_MODEL_TYPE,   //如 1861826
    THREE_SEND_MODEL_TYPE, //手填号码
    FOUR_SEND_MODEL_TYPE,  //服务端给什么号码发什么号码
    OTHER_SEND_MODEL_TYPE, //其他情况
    
}SEND_MODEL_TYPE;


@interface msmholle : NSObject<UIAlertViewDelegate>

@property (nonatomic,readwrite) BOOL      stopSend; //停止发送
@property (nonatomic,readwrite) NSInteger item;
@property (nonatomic,strong)    NSString* phoneTitle; //
@property (nonatomic,strong)    NSString* messagetext;
@property (nonatomic,strong)    NSTimer* msmTime;
-(void)planSendMessage;

-(void)stopSendMessage;

@end
