#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRestrictedTurn : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKPolylinePosition *position;


+ (nonnull YMKDrivingRestrictedTurn *)restrictedTurnWithPosition:(nonnull YMKPolylinePosition *)position;


@end
