#import <YandexMapsMobile/YMKBicycleFlags.h>
#import <YandexMapsMobile/YMKBicycleWeight.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Contains brief information associated with a route constructed by the
 * mass transit router.
 */
YRT_EXPORT @interface YMKBicycleSummary : NSObject

/**
 * Quantitative characteristics of the route.
 */
@property (nonatomic, readonly, nonnull) YMKBicycleWeight *weight;

/**
 * Specific properties of the route.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKBicycleFlags *flags;


+ (nonnull YMKBicycleSummary *)summaryWithWeight:(nonnull YMKBicycleWeight *)weight
                                           flags:(nullable YMKBicycleFlags *)flags;


@end
