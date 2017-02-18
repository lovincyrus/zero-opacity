import Foundation
import MapboxDirections


/*
 `AlertLevel` is used to control when and the type of alert notification the user should recieve.
*/
@objc(MBAlertLevel)
public enum AlertLevel: Int {
    
    /*
     Default `AlertLevel`
    */
    case none
    
    
    /*
     The user has started the route.
     */
    case depart
    
    
    /*
     The user has recently completed a step.
    */
    case low
    
    
    /*
     The user is approaching the maneuver.
    */
    case medium
    
    
    /*
     The user is at or very close to the maneuver point
    */
    case high
    
    
    /*
     The user has completed the route.
    */
    case arrive
}


/*
 `routeProgress` contains all progress information of user along the route, leg and step.
 */
@objc(MBRouteProgress)
open class RouteProgress: NSObject {
    open let route: Route

    /*
     Index representing current leg
     */
    open var legIndex: Int {
        didSet {
            assert(legIndex >= 0 && legIndex < route.legs.endIndex)
            // TODO: Set stepIndex to 0 or last index based on whether leg index was incremented or decremented.
            currentLegProgress = RouteLegProgress(leg: currentLeg)
        }
    }


    /*
     If waypoints are provided in the `Route`, this will contain which leg the user is on.
     */
    open var currentLeg: RouteLeg {
        return route.legs[legIndex]
    }

    
    /*
     Total distance traveled by user along all legs.
     */
    open var distanceTraveled: CLLocationDistance {
        return route.legs.prefix(upTo: legIndex).map { $0.distance }.reduce(0, +) + currentLegProgress.distanceTraveled
    }
    

    /*
     Total seconds remaining on all legs
     */
    open var durationRemaining: CLLocationDistance {
        return route.legs.suffix(from: legIndex + 1).map { $0.expectedTravelTime }.reduce(0, +) + currentLegProgress.durationRemaining
    }

    
    /*
     Number between 0 and 1 representing how far along the `Route` the user has traveled.
     */
    open var fractionTraveled: Double {
        return distanceTraveled / route.distance
    }


    /*
     Total distance remaining in meters along route.
     */
    open var distanceRemaining: CLLocationDistance {
        return route.distance - distanceTraveled
    }

    
    open var currentLegProgress: RouteLegProgress!

    
    public init(route: Route, legIndex: Int = 0) {
        self.route = route
        self.legIndex = legIndex
        super.init()
        currentLegProgress = RouteLegProgress(leg: currentLeg)
    }
}

@objc(MBRouteLegProgress)
open class RouteLegProgress: NSObject {
    open let leg: RouteLeg
    
    
    /*
     Index representing the current step
    */
    open var stepIndex: Int {
        didSet {
            assert(stepIndex >= 0 && stepIndex < leg.steps.endIndex)
            currentStepProgress = RouteStepProgress(step: currentStep)
        }
    }


    /*
     Total distance traveled in meters along current leg
     */
    open var distanceTraveled: CLLocationDistance {
        return leg.steps.prefix(upTo: stepIndex).map { $0.distance }.reduce(0, +) + currentStepProgress.distanceTraveled
    }
    
    
    /*
     Duration remaining in seconds on current leg
     */
    open var durationRemaining: TimeInterval {
        return leg.steps.suffix(from: stepIndex + 1).map { $0.expectedTravelTime }.reduce(0, +) + currentStepProgress.durationRemaining
    }


    /*
     Number between 0 and 1 representing how far along the current leg the user has traveled.
    */
    open var fractionTraveled: Double {
        return distanceTraveled / leg.distance
    }

    
    open var alertUserLevel: AlertLevel = .none

    
    open func stepBefore(_ step: RouteStep) -> RouteStep? {
        guard let index = leg.steps.index(of: step) else {
            return nil
        }
        if index > 0 {
            return leg.steps[index-1]
        }
        return nil
    }
    
    open func stepAfter(_ step: RouteStep) -> RouteStep? {
        guard let index = leg.steps.index(of: step) else {
            return nil
        }
        if index+1 < leg.steps.endIndex {
            return leg.steps[index+1]
        }
        return nil
    }
    
    
    /*
     Returns number representing current `Step` for the leg the user is on.
     */
    open var currentStep: RouteStep {
        return leg.steps[stepIndex]
    }


    /*
     Returns the upcoming `Step`.
     
     If there is no `upcomingStep`, nil is returned.
     */
    open var upComingStep: RouteStep? {
        guard stepIndex + 1 < leg.steps.endIndex else {
            return nil
        }
        return leg.steps[stepIndex + 1]
    }

    /*
     Returns step 2 steps ahead.
     
     If there is no `followOnStep`, nil is returned.
    */
    open var followOnStep: RouteStep? {
        guard stepIndex + 2 < leg.steps.endIndex else {
            return nil
        }
        return leg.steps[stepIndex + 2]
    }


    /*
     Return bool whether step provided is the current `Step` the user is on.
    */
    open func isCurrentStep(_ step: RouteStep) -> Bool {
        return leg.steps.index(of: step) == stepIndex
    }


    open var currentStepProgress: RouteStepProgress


    public init(leg: RouteLeg, stepIndex: Int = 0) {
        self.leg = leg
        self.stepIndex = stepIndex
        currentStepProgress = RouteStepProgress(step: leg.steps[stepIndex])
    }
}

@objc(MBRouteStepProgress)
open class RouteStepProgress: NSObject {

    open let step: RouteStep


    /*
     Returns distance user has traveled along current step.
    */
    open var distanceTraveled: CLLocationDistance = 0
    
    
    /*
     Returns distance from user to end of step.
    */
    open var userDistanceToManeuverLocation: CLLocationDistance? = nil
    
    /*
     Total distance in meters remaining on current stpe
     */
    open var distanceRemaining: CLLocationDistance {
        return step.distance - distanceTraveled
    }

    /*
     Number between 0 and 1 representing fraction of current step traveled
    */
    open var fractionTraveled: Double {
        return distanceTraveled / step.distance
    }


    /*
     Number of seconds remaining on current step
     */
    open var durationRemaining: TimeInterval {
        return (1 - fractionTraveled) * step.expectedTravelTime
    }


    public init(step: RouteStep) {
        self.step = step
    }
}
