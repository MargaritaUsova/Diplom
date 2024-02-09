#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * The intensity of traffic.
 */
typedef NS_ENUM(NSUInteger, YMKDrivingJamType) {
    /**
     * Unknown intensity.
     */
    YMKDrivingJamTypeUnknown,
    /**
     * Route is blocked.
     */
    YMKDrivingJamTypeBlocked,
    /**
     * Route is free.
     */
    YMKDrivingJamTypeFree,
    /**
     * Light traffic on route.
     */
    YMKDrivingJamTypeLight,
    /**
     * Heavy traffic on route.
     */
    YMKDrivingJamTypeHard,
    /**
     * Very heavy traffic on route.
     */
    YMKDrivingJamTypeVeryHard
};

/**
 * A segment of a traffic jam that has specific traffic conditions.
 */
YRT_EXPORT @interface YMKDrivingJamSegment : NSObject

/**
 * The type of the traffic jam.
 */
@property (nonatomic, readonly) YMKDrivingJamType jamType;

/**
 * The speed at which traffic is moving.
 */
@property (nonatomic, readonly) double speed;


+ (nonnull YMKDrivingJamSegment *)jamSegmentWithJamType:( YMKDrivingJamType)jamType
                                                  speed:( double)speed;


@end
