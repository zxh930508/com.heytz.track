/********* PushService Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "BaiduTraceSDK/BaiduTraceSDK.h"

@interface trackWrapper : CDVPlugin {
  // Member variables go here.
    NSUInteger serviceID;
    NSString *AK;
    NSString *mcode;
    NSString *entityName;
    NSUInteger serverFenceID;
    NSUInteger localFenceID;
    BTKServiceOption *sop;
}

- (void)startTrack:(CDVInvokedUrlCommand*)command;
@end

@implementation trackWrapper

- (void)pluginInitialize {
    AK = @"4MGRWbGSsjq87oIr0yZmpMst1ieP0fHU";
    mcode = @"com.heytz.YYang.app";
    NSLog(@"Cordova Heytz Track Plugin");
    [super pluginInitialize];
}

- (void)startTrack:(CDVInvokedUrlCommand*)command
{

    NSString *ID = [command.arguments objectAtIndex:1];
    serviceID = [ID integerValue];
    entityName =  [command.arguments objectAtIndex:2];
    [self.commandDelegate runInBackground:^{
    sop = [[BTKServiceOption alloc] initWithAK:AK mcode:mcode serviceID:serviceID keepAlive:false];
    [[BTKAction sharedInstance] initInfo:sop];
    BTKStartServiceOption *op = [[BTKStartServiceOption alloc] initWithEntityName:entityName];
    [[BTKAction sharedInstance] startService:op delegate:self.appDelegate];
        sleep(1);
    [[BTKAction sharedInstance] startGather:self.appDelegate];
    }];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];;
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)stopTrack:(CDVInvokedUrlCommand*)command
{
    [[BTKAction sharedInstance] stopGather:self.appDelegate];
    [[BTKAction sharedInstance] stopService:self.appDelegate];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];;
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
