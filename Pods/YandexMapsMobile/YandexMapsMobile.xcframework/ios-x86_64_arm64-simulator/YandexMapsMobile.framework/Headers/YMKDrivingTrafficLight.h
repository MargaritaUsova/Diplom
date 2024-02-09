#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * A traffic light object.
 */
YRT_EXPORT @interface YMKDrivingTrafficLight : NSObject

/**
 * The position of the traffic light.
 */
@property (nonatomic, readonly, nonnull) YMKPolylinePosition *position;


+ (nonnull YMKDrivingTrafficLight *)trafficLightWithPosition:(nonnull YMKPolylinePosition *)position;


@end
