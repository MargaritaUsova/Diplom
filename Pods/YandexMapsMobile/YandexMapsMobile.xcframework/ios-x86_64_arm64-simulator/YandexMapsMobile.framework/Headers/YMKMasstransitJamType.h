#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * Undocumented
 */
typedef NS_ENUM(NSUInteger, YMKMasstransitJamType) {
    /**
     * Unknown traffic intensity.
     */
    YMKMasstransitJamTypeUnknown,
    /**
     * Route is closed.
     */
    YMKMasstransitJamTypeClosed,
    /**
     * Route is clear.
     */
    YMKMasstransitJamTypeFree,
    /**
     * Light traffic on route.
     */
    YMKMasstransitJamTypeLight,
    /**
     * Heavy traffic on route.
     */
    YMKMasstransitJamTypeHard,
    /**
     * Very heavy traffic on route.
     */
    YMKMasstransitJamTypeVeryHard
};
