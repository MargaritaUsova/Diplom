#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingTollRoad : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKSubpolyline *position;


+ (nonnull YMKDrivingTollRoad *)tollRoadWithPosition:(nonnull YMKSubpolyline *)position;


@end
