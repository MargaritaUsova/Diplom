#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRuggedRoad : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKSubpolyline *position;

/**
 * Undocumented
 */
@property (nonatomic, readonly) BOOL unpaved;

/**
 * Undocumented
 */
@property (nonatomic, readonly) BOOL inPoorCondition;


+ (nonnull YMKDrivingRuggedRoad *)ruggedRoadWithPosition:(nonnull YMKSubpolyline *)position
                                                 unpaved:( BOOL)unpaved
                                         inPoorCondition:( BOOL)inPoorCondition;


@end
