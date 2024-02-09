#import <YandexMapsMobile/YMKBicycleSession.h>
#import <YandexMapsMobile/YMKRequestPoint.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Undocumented
 */
typedef NS_ENUM(NSUInteger, YMKBicycleVehicleType) {
    /**
     * Undocumented
     */
    YMKBicycleVehicleTypeBicycle,
    /**
     * Undocumented
     */
    YMKBicycleVehicleTypeScooter
};

/**
 * Provides methods for submitting bicycle routing requests.
 */
YRT_EXPORT @interface YMKBicycleRouter : NSObject

/**
 * @attention This feature is not available in the free MapKit version.
 *
 *
 * Submits a request to find a bicycle route.
 *
 * @param points Route points (See YMKRequestPoint for details).
 * Currently only two points are supported (start and finish).
 * @param routeListener Listener to retrieve a list of Route objects.
 */
- (nonnull YMKBicycleSession *)requestRoutesWithPoints:(nonnull NSArray<YMKRequestPoint *> *)points
                                                  type:(YMKBicycleVehicleType)type
                                         routeListener:(nonnull YMKBicycleSessionRouteListener)routeListener;

/**
 * @attention This feature is not available in the free MapKit version.
 *
 *
 * Submits a request to fetch a brief summary of the bicycle routes.
 *
 * @param points Route points (See YMKRequestPoint for details).
 * Currently only two points are supported (start and finish).
 * @param summaryListener Listener to retrieve a list of Route objects.
 */
- (nonnull YMKBicycleSummarySession *)requestRoutesSummaryWithPoints:(nonnull NSArray<YMKRequestPoint *> *)points
                                                                type:(YMKBicycleVehicleType)type
                                                      summaryHandler:(nonnull YMKBicycleSummarySessionSummaryHandler)summaryHandler;

/**
 * @attention This feature is not available in the free MapKit version.
 *
 *
 * Submits a request to retrieve detailed information on a bicycle route
 * by URI.
 *
 * @param uri The URI of the bicycle route. Starts with
 * "ymapsbm1://route/bicycle".
 * @param routeListener Listener to retrieve a list of Route objects.
 */
- (nonnull YMKBicycleSession *)resolveUriWithUri:(nonnull NSString *)uri
                                   routeListener:(nonnull YMKBicycleSessionRouteListener)routeListener;

@end
