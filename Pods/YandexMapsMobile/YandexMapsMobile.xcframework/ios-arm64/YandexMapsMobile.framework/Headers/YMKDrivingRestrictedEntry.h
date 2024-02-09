#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * A restricted entry object.
 */
YRT_EXPORT @interface YMKDrivingRestrictedEntry : NSObject

/**
 * The position of the restricted entry.
 */
@property (nonatomic, readonly, nonnull) YMKPolylinePosition *position;


+ (nonnull YMKDrivingRestrictedEntry *)restrictedEntryWithPosition:(nonnull YMKPolylinePosition *)position;


@end
