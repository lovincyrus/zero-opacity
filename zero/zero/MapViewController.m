// set up watchconnectivity api

// LA: 37.369168
// LONG: -122.038412
// Zoom Level: 14

/********************************/
// CS63A - Winter 2017
// HW2: Milestone 2
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


@interface MyCustomPointAnnotation : MGLPointAnnotation
@end

@implementation MyCustomPointAnnotation
@end

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

    // Needs to be here to track location when started
    self.mapView.userTrackingMode = MGLUserTrackingModeFollow;
    self.mapView.delegate = self;
}






// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






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




// Return a random floating-point value between 0 and 1
//-(CGFloat)randomValueBetween0And1{
//    return (float)rand()/RAND_MAX;
//}




// Generates a random point of origin within the self.canvas' bounds
-(CGPoint)randomPatchOriginLocation{
    CGPoint origin;
//    origin.x = self.canvas.bounds.size.width*[self randomValueBetween0And1];
//    origin.y = self.canvas.bounds.size.height*[self randomValueBetween0And1];
    return origin;
}



- (IBAction)addMarker:(id)sender {
    NSLog(@"addMarker pressed");

    MGLMapView *mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds
                                                   styleURL: [NSURL URLWithString:@"mapbox://styles/mapbox/dark-v9"]];

    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.delegate = self;

    MGLPointAnnotation *point0 = [[MGLPointAnnotation alloc] init];
    MGLPointAnnotation *point1 = [[MGLPointAnnotation alloc] init];
    MyCustomPointAnnotation *point2 = [[MyCustomPointAnnotation alloc] init];

    point0.coordinate = CLLocationCoordinate2DMake(37.369168, -122.038412);
    point0.title = @"Chick-fil-A";
    point0.subtitle = @"550 W El Camino Real, Sunnyvale, CA 94087";

    point1.coordinate = CLLocationCoordinate2DMake(37.328669, -122.02084809999997);
    point1.title = @"Sunnyvale";
    point1.subtitle = @"I said Sunnyvale!";

    point2.coordinate = CLLocationCoordinate2DMake(36.4623,-116.8656);
    point2.title = @"Stovepipe Wells";
    point2.subtitle = @"Testing";

    NSArray *myPlaces = @[point0, point1, point2];

    [self.view addSubview:mapView];

    // add the annotation to the map view
    [mapView addAnnotations:myPlaces];
}


//self.mapView.userTrackingMode = MGLUserTrackingModeFollow;
//self.mapView.delegate = self;

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
