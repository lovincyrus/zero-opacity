/**
 
 // original testing annotation
 LA: 37.369168
 LONG: -122.038412
 Zoom Level: 14

 // setting mapbox style
 [self.mapView setStyleURL:[MGLStyle streetsStyleURLWithVersion:dark-v9]];
 


**/



/********************************/
// CS63A - Winter 2017
// HW1: Milestone 1
// Student Name: Cyrus Goh
// SID: 20186628
/********************************/

//
//  MapViewController.m
//  zero
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "MapViewController.h"
@import Mapbox;
@import MapboxNavigation;
@import MapboxDirections;

@interface MapViewController () <MGLMapViewDelegate>
@property (strong, nonatomic) IBOutlet MGLMapView *mapView;

@property (nonatomic) MBRouteController *navigation;
@end

@implementation MapViewController

static NSString *MBXTempProfileIdentifierAutomobileAvoidingTraffic = @"mapbox/driving-traffic";

// female: 👮‍♀️👮🏻‍♀️👮🏼‍♀️👮🏽‍♀️👮🏾‍♀️👮🏿‍♀️
// male: 👮👮🏻👮🏼👮🏽👮🏾👮🏿
// add rand() array of cops annotation on the map
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad MapVC");

    self.mapView.userTrackingMode = MGLUserTrackingModeFollow;

    // set the map view's delegate property
    self.mapView.delegate = self;

    // create annotation and assign it to local variable point
    MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];

    // give the point annotation a coordinate
<<<<<<< HEAD
//    point.coordinate = CLLocationCoordinate2DMake(37.369168, -122.038412);
//    point.title = @"Chick-fil-A";
//    point.subtitle = @"550 W El Camino Real, Sunnyvale, CA 94087";

    // add the annotation to the map view
//    [self.mapView addAnnotation:point];
=======
    //point.coordinate = CLLocationCoordinate2DMake(37.369168, -122.038412);
    point.title = @"Chick-fil-A";
    point.subtitle = @"550 W El Camino Real, Sunnyvale, CA 94087";

    // add the annotation to the map view
    [self.mapView addAnnotation:point];


>>>>>>> parent of 823946e... iOS and watchOS successfully send data and trigger haptic feedback
}



// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

<<<<<<< HEAD






=======
// mapview
>>>>>>> parent of 823946e... iOS and watchOS successfully send data and trigger haptic feedback
// Tapping the annotation (display title and subtitle)
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always try to show a callout when an annotation is tapped.
    return YES;
}

- (void)startNavigation:(MBRoute *)route {
    self.mapView.userTrackingMode = MGLUserTrackingModeFollowWithCourse;
    self.navigation = [[MBRouteController alloc] initWithRoute:route];
    [self.navigation resume];
}





//- (void)reportPressed {
//    // reportPressed -> creates annotation on that current location
//}
//
//
//
//
//
//
//- (IBAction)yesButtonPressed:(id)sender {
//    [self.replyLabel setText:@"Sending Yes..."];
//
//    self.counter++;
//    self.counterLabel.text = [NSString stringWithFormat:@"%i",_counter];
//
//    //Build message and send
//    [self packageAndSendMessage:@{@"request":@"Yes",@"counter":[NSString stringWithFormat:@"%i",_counter]}];
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end
