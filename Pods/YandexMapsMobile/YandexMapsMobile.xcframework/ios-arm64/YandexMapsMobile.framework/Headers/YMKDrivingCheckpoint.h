#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * A checkpoint object.
 */
YRT_EXPORT @interface YMKDrivingCheckpoint : NSObject

/**
 * The position of the checkpoint.
 */
@property (nonatomic, readonly, nonnull) YMKPolylinePosition *position;


+ (nonnull YMKDrivingCheckpoint *)checkpointWithPosition:(nonnull YMKPolylinePosition *)position;


@end
