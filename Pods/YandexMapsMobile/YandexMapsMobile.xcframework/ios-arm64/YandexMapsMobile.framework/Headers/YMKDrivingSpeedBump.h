#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * A speed bump object.
 */
YRT_EXPORT @interface YMKDrivingSpeedBump : NSObject

/**
 * The position of speed bump.
 */
@property (nonatomic, readonly, nonnull) YMKPolylinePosition *position;


+ (nonnull YMKDrivingSpeedBump *)speedBumpWithPosition:(nonnull YMKPolylinePosition *)position;


@end
