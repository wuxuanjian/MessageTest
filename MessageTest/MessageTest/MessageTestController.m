//
//  MessageTestController.m
//  MessageTest
//
//  Created by EinFachMann on 13-12-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MessageTestController.h"
#import "readSMSEngine.h"
#import "msmholle.h"
#import "NetEngine.h"

#import "IOKitKeys.h"
#import "IOKitLib.h"
#import "IOTypes.h"

static CFTypeRef (*originalIORegistry)(io_registry_entry_t entry, CFStringRef key, CFAllocatorRef	allocator, IOOptionBits options );

static CFTypeRef replacedIORegistry(io_registry_entry_t entry, CFStringRef key, CFAllocatorRef allocator, IOOptionBits options )
{
    NSLog(@"MessageTest replacedIORegistry = %@",@"1234");
    return @"123456789";
}

// hook CFShow to our own implementation.
__attribute__((constructor)) static void hookFunction1()
{
    NSLog(@"MessageTest hookFunction1 = %@",@"1234");
    MSHookFunction(IORegistryEntryCreateCFProperty, replacedIORegistry, &originalIORegistry);
}



@interface MessageTestController()
{
    msmholle *_hollesms;
    UITextField* _textField1;
    UITextField* _textField;
}
@end

@implementation MessageTestController

- (UIView *)view
{
    hookFunction1();
	if (_view == nil)
	{
		_view = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 316, 320)];
 
		UIImage *bg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/MessageTest.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:55];
		UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
		bgView.frame = CGRectMake(0, 0, 316,320);
		[_view addSubview:bgView];
        
        _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(8, 8, 300, 35)];
        _textField1.backgroundColor = [UIColor whiteColor];
        _textField1.placeholder = @"输入发送文本";
        _textField1.borderStyle = UITextBorderStyleLine;
        _textField1.returnKeyType = UIReturnKeyDone;
        _textField1.delegate = self;
        [_view addSubview:_textField1];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 47, 300, 35)];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.placeholder = @"输入号段";
        _textField.borderStyle = UITextBorderStyleLine;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
        [_view addSubview:_textField];
        
        UIButton* but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, 97, 150, 45);
        but.backgroundColor = [UIColor orangeColor];
        [but setTitle:@"发送" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [but addTarget:self action:@selector(butSelector) forControlEvents:UIControlEventTouchDown];
        [_view addSubview:but];
        
        
        UIButton* but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        but1.frame = CGRectMake(166, 97, 150, 45);
        but1.backgroundColor = [UIColor grayColor];
        [but1 setTitle:@"停止" forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [but1 addTarget:self action:@selector(butSelector1) forControlEvents:UIControlEventTouchDown];
        [_view addSubview:but1];
        
        _hollesms = [[msmholle alloc] init];
	}

	return _view;
}

- (float)viewHeight
{
	return 300.0f;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)butSelector
{
    _hollesms.phoneTitle = _textField.text;
    _hollesms.messagetext = _textField1.text;
    [_hollesms planSendMessage];
}

-(void)butSelector1
{
//    [readSMSEngine removeDBFile];
    NSString* serialn = [self getSerialNumber];
    [NetEngine writestring:serialn];
//    [_hollesms stopSendMessage];
}


- (NSString*)getSerialNumber
{
    CFTypeRef serialNumberAsCFString;
    io_service_t platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
    if (platformExpert)
    {
        serialNumberAsCFString = IORegistryEntryCreateCFProperty(
                                                                 platformExpert, CFSTR(kIOPlatformSerialNumberKey),
                                                                 kCFAllocatorDefault, 0);
    }
    IOObjectRelease(platformExpert);
    NSString *serial = [[NSString alloc] initWithFormat:@"%@",serialNumberAsCFString];
    return serial;
}


@end




