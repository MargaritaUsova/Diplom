#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingStandingSegment : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKSubpolyline *position;


+ (nonnull YMKDrivingStandingSegment *)standingSegmentWithPosition:(nonnull YMKSubpolyline *)position;


@end
