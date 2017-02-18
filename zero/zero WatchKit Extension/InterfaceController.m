//
//  InterfaceController.m
//  zero WatchKit Extension
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>


@interface InterfaceController() <WCSessionDelegate>

// reportBtn
//@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *reportBtn;

// session
@property (strong, nonatomic) WCSession *session;

@end


@implementation InterfaceController

-(instancetype)init {
    self = [super init];

    // check if a session is supported
    if (self) {
        if ([WCSession isSupported]) {
            self.session = [WCSession defaultSession];
            self.session.delegate = self;
            [self.session activateSession];
        }
    }
    return self;
}




// activeationDidCompleteWithState
- (void)session:(WCSession *)session
activationDidCompleteWithState:(WCSessionActivationState)activationState
          error:(NSError *)error {
}



//
//- (void)awakeWithContext:context {
//    [super awakeWithContext:context];
//    NSLog(@"Passed %@",context);
//}




- (void)willActivate {
// This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"%@ willActivate (HANDS UP)", self);
}




- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"%@ didDeactivate (HANDS DOWN)", self);
}




<<<<<<< HEAD

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    if(message){
        NSString* command = [message objectForKey:@"request"];
        [self.replyLabel setText:command];

        NSString* otherCounter = [message objectForKey:@"counter"];
        NSDictionary* response = @{@"response" : [NSString stringWithFormat:@"Message %@ received.",otherCounter]} ;

        if (replyHandler != nil) replyHandler(response);
    }
}




-(void)packageAndSendMessage:(NSDictionary*)request {
    // check session
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];

        if(session.reachable) {
            [session sendMessage:request
                    replyHandler:
             ^(NSDictionary<NSString *,id> * __nonnull replyMessage) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSLog(@"--- replyHandler called --- %@",replyMessage);
                     NSDictionary* message = replyMessage;
                     NSString* response = message[@"response"];

                        // Haptic Types
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeSuccess];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeDirectionUp];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeDirectionDown];
                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeFailure];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeRetry];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeStart];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeStop];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeClick];


                     if(response)
                         [self.replyLabel setText:response];
                     else
                         [self.replyLabel setText:@"nil"];
                 });
             }
                    errorHandler:^(NSError * __nonnull error) {

                    // Failure Haptic
                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeFailure];

                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.replyLabel setText:error.localizedDescription];
                        });
                    }
             ];
        }
        else {
            [self.replyLabel setText:@"Session Not reachable"];
        }

    }
    else {
        [self.replyLabel setText:@"Session Not Supported"];
    }





}









/** 
 
 Standard Wathckit Delegate

**/

-(void)sessionWatchStateDidChange:(nonnull WCSession *)session {
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
    }
=======
- (IBAction)reportPressed {
    [self sendReport:@"Report"];
    NSLog(@"reportPressed");
>>>>>>> parent of 823946e... iOS and watchOS successfully send data and trigger haptic feedback
}




// send report to reportLabel
-(void)sendReport:(NSString *)report {
    NSDictionary *applicationDict = @{@"report":report};
    [self.session updateApplicationContext:applicationDict error:nil];

    NSLog(@"sendReport");

}



<<<<<<< HEAD

- (IBAction)yesButtonPressed {
    [self.replyLabel setText:@"Sending Yes..."];

    self.counter++;
    [self setTitle:[NSString stringWithFormat:@"%i",_counter]];

    [self packageAndSendMessage:@{@"request":@"Yes",@"counter":[NSString stringWithFormat:@"%i",_counter]}];

}



- (IBAction)noButtonPressed {
    [self.replyLabel setText:@"Sending No..."];

    self.counter++;
    [self setTitle:[NSString stringWithFormat:@"%i",_counter]];

    [self packageAndSendMessage:@{@"request":@"No",@"counter":[NSString stringWithFormat:@"%i",_counter]}];
}



=======
>>>>>>> parent of 823946e... iOS and watchOS successfully send data and trigger haptic feedback
@end
