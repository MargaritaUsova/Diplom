#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * A pedestrian crossing object.
 */
YRT_EXPORT @interface YMKDrivingPedestrianCrossing : NSObject

/**
 * The position of pedestrian crossing.
 */
@property (nonatomic, readonly, nonnull) YMKPolylinePosition *position;


+ (nonnull YMKDrivingPedestrianCrossing *)pedestrianCrossingWithPosition:(nonnull YMKPolylinePosition *)position;


@end
