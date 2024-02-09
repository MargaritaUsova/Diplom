#import <YandexMapsMobile/YMKBicycleWeight.h>
#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Leg of the route.
 */
YRT_EXPORT @interface YMKBicycleLeg : NSObject

/**
 * Quantitative characteristics of the route leg.
 */
@property (nonatomic, readonly, nonnull) YMKBicycleWeight *weight;

/**
 * Path of the route polyline for the route leg.
 */
@property (nonatomic, readonly, nonnull) YMKSubpolyline *geometry;


+ (nonnull YMKBicycleLeg *)legWithWeight:(nonnull YMKBicycleWeight *)weight
                                geometry:(nonnull YMKSubpolyline *)geometry;


@end
