//
//  GetStartedViewController.m
//  zero
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "GetStartedViewController.h"
//#import "MapViewController.m"

@interface GetStartedViewController ()

@end

@implementation GetStartedViewController

// Do any additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad GetStartedVC");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//openMapSegue

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if([segue.identifier isEqualToString:@"openMapSegue"])
 if([segue.destinationViewController isMemberOfClass:[MapViewController class]]){
 MapViewController* bvc = (MapViewController*)segue.destinationViewController;
 //bvc.backgroundColor = ((UIButton*)sender).backgroundColor;
 //bvc.navTitle = ((UIButton*)sender).currentTitle;
 }

 }

*/

// setting up segue from GetStartedVC to MapVC
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // ensure the correct segue to fire
    if([segue.identifier isEqualToString:@"openMapSegue"])
        // ensure the correct destination class
        if([segue.destinationViewController isMemberOfClass:[UIViewController class]]){
            // cast destination class to be B
//            UIViewController* bvc = (UIViewController*)segue.destinationViewController;
            // info passing from A to B
//            bvc.backgroundColor = ((UIButton*)sender).backgroundColor;
            //bvc.navTitle = ((UIButton*)sender).currentTitle;
        }

}

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier
//                                  sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"openMagSegue"])
//        return [self] ? YES : NO;
//    else
//        return NO;
//}

@end
