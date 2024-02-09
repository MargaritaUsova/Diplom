#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Special point on the route (like gates).
 */
YRT_EXPORT @interface YMKBicycleRestrictedEntry : NSObject

/**
 * Entry position on the route polyline.
 */
@property (nonatomic, readonly, nonnull) YMKPolylinePosition *position;


+ (nonnull YMKBicycleRestrictedEntry *)restrictedEntryWithPosition:(nonnull YMKPolylinePosition *)position;


@end
