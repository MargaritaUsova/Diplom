#import <YandexMapsMobile/YMKLocalizedValue.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Quantitative characteristics of a route or route section.
 */
YRT_EXPORT @interface YMKBicycleWeight : NSObject

/**
 * Time to travel.
 */
@property (nonatomic, readonly, nonnull) YMKLocalizedValue *time;

/**
 * Distance to travel.
 */
@property (nonatomic, readonly, nonnull) YMKLocalizedValue *distance;


+ (nonnull YMKBicycleWeight *)weightWithTime:(nonnull YMKLocalizedValue *)time
                                    distance:(nonnull YMKLocalizedValue *)distance;


@end
