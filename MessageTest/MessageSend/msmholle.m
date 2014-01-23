//
//  msmholle.m
//  hollewordwoo
//
//  Created by EinFachMann on 13-12-6.
//
//

#import "msmholle.h"
#import "readSMSEngine.h"
#import "NetEngine.h"
#import <UIKit/UIKit.h>
#import "CKSMSService.h"
#import "CKSMSMessage.h"
#import "CKConversationList.h"
#import "CKSMSEntity.h"
#import "_CKConversation.h"

#import "CKMessageComposition.h"
#import "CKMadridService.h"
#import "CKMadridMessage.h"
#import "CKSubConversation.h"
#import "CKMessageStandaloneComposition.h"
#import "CKMadridEntity.h"
#import "JSONKit.h"

@interface msmholle()
{
    NSString *phone;
    NSArray  *phoneArray;
    SEND_MODEL_TYPE sendType;
    BOOL     readmsmState; //读取短信数据库状态
}

@end


@implementation msmholle
@synthesize stopSend = _stopSend;
@synthesize item = _item;
@synthesize phoneTitle = _phoneTitle;
@synthesize messagetext = _messagetext;
@synthesize msmTime = _msmTime;
-(void)planSendMessage
{
    phoneArray = nil;
    readmsmState = NO;
    sendType = [self setSendType:_phoneTitle];
    phone = @""; // This is the phone number or email of the message recipient
    _item = 0;
    _stopSend = NO;
    if(_messagetext == nil || [_messagetext length] == 0)
    {
//        _messagetext = @"您好，短信测试。";
//        NSString *dbPath = @"/var/mobile/Library/SMS/500x500_3.jpg";
        _messagetext = @"【天天爱找图】\U0001F305找你妹微信版上线！\U0001F389快来加入微信游戏中心\U0001F389"
        "\n\U0001F388爆笑段子，全新上万物品随意找\U0001F367 "
        "\n\U0001F388全新剧情，全新关卡人物\U0001F436 "
        "\n\U0001F388风格更豪华，游戏无广告\U0001F48E "
        "\n\U0001F388全球微信排行快来找妹子私聊\U0001F497 "
        "\n \n访问"
        "\n\U0001F683搜索【天天爱找图pro】即刻下载"
        "\n地址：http://itunes.apple.com/cn/app/id689632128?ls=1&mt=8"
        "\n\U0001F4BB";
    }
    
    if(sendType == FOUR_SEND_MODEL_TYPE)
    {
        readmsmState = YES;
        [self fillPhoneNumber];
    }
    
    [self sendMSMTime];
}

-(void)stopSendMessage
{
    _stopSend = YES;
}

//发送短信time
-(void)sendMSMTime
{
    if (_msmTime == nil)
    {
        _msmTime = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startSendIMessage) userInfo:nil repeats:YES];
    }
}

//检测发送成功time
-(void)findSendIdTime
{
    readmsmState = YES;
    [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(findSendSucceedId) userInfo:nil repeats:NO];
}

- (void)startSendIMessage
{
    //关闭
    if([self getStopMSMTimeType])
    {
        _stopSend = YES;
        [_msmTime invalidate];
        _msmTime = nil;
        [self findSendIdTime];
        return;
    }
    
    //读取数据库 不在发送信息
    if(readmsmState == YES)
    {
        return;
    }
    
    [self phoneNumber];
    
    //Get a reference to the shared Madrid Service
    CKMadridService *madridService = [CKMadridService sharedMadridService];
    
    
    
    //Get a reference to the shared conversation list
    CKConversationList *conversationList = [CKConversationList sharedConversationList];
    
    CKMadridEntity *ckEntity; 
    ckEntity = [madridService copyEntityForAddressString:phone];
    
    NSArray* ckEntityArr = [NSArray arrayWithObject:ckEntity];
    CKSubConversation *conversation = [conversationList conversationForRecipients:ckEntityArr create:YES service:madridService];

//    BOOL vlid = [conversation isiMessageConversation];
//    if(vlid)
//    {
//        [NetEngine writestring:[NSString stringWithFormat:@"isValidAddress: %@ == yes",phone]];
//    }
//    else
//    {
//        [NetEngine writestring:[NSString stringWithFormat:@"isValidAddress: %@ == no",phone]];
//    }
    
    
    CKMessageStandaloneComposition *composition = [CKMessageStandaloneComposition newCompositionForText:_messagetext];
    
    // Create a message
    CKMadridMessage *message = [madridService newMessageWithComposition:composition forConversation:conversation];
    [madridService sendMessage:message];
    
    [self itemAdd];
}

//增加发送次数
-(void) itemAdd
{
    _item++;
    if(_item == [phoneArray count] || _item == 200)
    {
        _item = 0;
        [self findSendIdTime];
    }
}

//检测发送成功Id 发送1000条检测一次
-(void)findSendSucceedId
{
    
    if(sendType == FOUR_SEND_MODEL_TYPE)
    {
        //发送网络请求
        [self doAddNetPhone];
    }
    else
    {
        readmsmState = NO;
    }
    
}

//返回 停止发送状态
-(BOOL)getStopMSMTimeType
{
    if(_stopSend == YES)
    {
        return YES;
    }
    
    if(sendType == ONE_SEND_MODEL_TYPE && _item == 100000000)
    {
        return YES;
    }
    else if(sendType == TWO_SEND_MODEL_TYPE && _item == 10000)
    {
        return YES;
    }
    else if(sendType == THREE_SEND_MODEL_TYPE && _item > 0)//给单个手机发送20条信息
    {
        return YES;
    }
//    else if(sendType == FOUR_SEND_MODEL_TYPE) // 服务端
//    {
//
//    }
    else if(sendType == OTHER_SEND_MODEL_TYPE && _item > 0)
    {
        return YES;
    }
    return NO;
}

//算出手机号码
-(void)phoneNumber
{
    if(sendType == ONE_SEND_MODEL_TYPE)
    {
        phone = [self PhoneNumber1:_phoneTitle endNumber:_item];
    }
    else if(sendType == TWO_SEND_MODEL_TYPE)
    {
        phone = [self PhoneNumber2:_phoneTitle endNumber:_item];
    }
    else if(sendType == THREE_SEND_MODEL_TYPE)
    {
        phone = [NSString stringWithFormat:@"+86%@",_phoneTitle];
    }
    else if(sendType == FOUR_SEND_MODEL_TYPE)
    {
        phone = [NSString stringWithFormat:@"+86%@",[phoneArray objectAtIndex:_item]];
    }
    else if(sendType == OTHER_SEND_MODEL_TYPE)
    {
        phone = _phoneTitle; //暂代邮箱
    }
    
}

//如 186 尾号拼接
-(NSString*)PhoneNumber1:(NSString*)pTitle endNumber:(NSInteger)count
{
    NSString* str = nil;
    NSString* phoneTail = nil;
    if(count < 10)
    {
        phoneTail = [NSString stringWithFormat:@"0000000%d",count];
    }
    else if(count < 100)
    {
        phoneTail = [NSString stringWithFormat:@"000000%d",count];
    }
    else if(count < 1000)
    {
        phoneTail = [NSString stringWithFormat:@"00000%d",count];
    }
    else if(count < 10000)
    {
        phoneTail = [NSString stringWithFormat:@"0000%d",count];
    }
    else if(count < 100000)
    {
        phoneTail = [NSString stringWithFormat:@"000%d",count];
    }
    else if(count < 1000000)
    {
        phoneTail = [NSString stringWithFormat:@"00%d",count];
    }
    else if(count < 10000000)
    {
        phoneTail = [NSString stringWithFormat:@"0%d",count];
    }
    else if(count < 100000000)
    {
        phoneTail = [NSString stringWithFormat:@"%d",count];
    }
    str = [NSString stringWithFormat:@"+86%@%@",pTitle,phoneTail];
    return str;
}

//如 1861826 尾号拼接
-(NSString*)PhoneNumber2:(NSString*)pTitle endNumber:(NSInteger)count
{
    NSString* str = nil;
    NSString* phoneTail = nil;
    if(count < 10)
    {
        phoneTail = [NSString stringWithFormat:@"000%d",count];
    }
    else if(count < 100)
    {
        phoneTail = [NSString stringWithFormat:@"00%d",count];
    }
    else if(count < 1000)
    {
        phoneTail = [NSString stringWithFormat:@"0%d",count];
    }
    else if(count < 10000)
    {
        phoneTail = [NSString stringWithFormat:@"%d",count];
    }
    str = [NSString stringWithFormat:@"+86%@%@",pTitle,phoneTail];
    return str;

}

//发送类型
-(SEND_MODEL_TYPE)setSendType:(NSString*)pTitle
{
    SEND_MODEL_TYPE type = OTHER_SEND_MODEL_TYPE;
    if([pTitle length] == 3)
    {
        type = ONE_SEND_MODEL_TYPE;
    }
    else if([pTitle length] == 7)
    {
        type = TWO_SEND_MODEL_TYPE;
    }
    else if([pTitle length] == 11)
    {
        type = THREE_SEND_MODEL_TYPE;
    }
    else if([pTitle length] == 0)
    {
        type = FOUR_SEND_MODEL_TYPE;
    }
    else
    {
        type = OTHER_SEND_MODEL_TYPE;
    }
    return type;
}

////////////////////////网络请求
//获取电话
-(void)fillPhoneNumber
{
    NetEngine* nEngine = [NetEngine postEngineShare];
    [nEngine sendNumberCompletion:^(NSString *responseString)
    {
        [self sendNumberSucceed:responseString];
    }
    onError:^(NSError *err)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"获取号码失败" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }];
}

-(void)sendNumberSucceed:(NSString*)reqString
{
    if(reqString == nil || [reqString isEqualToString:@""])
    {
        _stopSend = YES;
        return;
    }
    NSDictionary* dic = [reqString JSONValue];
//    NSString* content = [dic objectForKey:@"content"];
//    if(content != nil && ![content isEqualToString:@""])
//    {
//        _messagetext = content;
//    }
    NSString* number = [dic objectForKey:@"number"];
    if(number == nil || [number isEqualToString:@""])
    {
        _stopSend = YES;
        return;
    }
    NSArray* pArr = [number componentsSeparatedByString: @","];
    NSMutableArray* pMuArr = [[NSMutableArray alloc] initWithCapacity:3];
    [pMuArr addObjectsFromArray:pArr];
    phoneArray = pMuArr;
    _item = 0;
    readmsmState = NO;
}

//提交电话
-(void)doAddNetPhone
{
    NetEngine* nEngine = [NetEngine postEngineShare];
    [nEngine doAddOnCompletion:^(NSString *responseString)
    {
        if(_stopSend == NO)
        {
            [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(fillPhoneNumber) userInfo:nil repeats:NO];
        }
        else
        {
            [readSMSEngine removeDBFile];
        }
    }
    onError:^(NSError *err)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"提交手机号码失败" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }];
}


@end
