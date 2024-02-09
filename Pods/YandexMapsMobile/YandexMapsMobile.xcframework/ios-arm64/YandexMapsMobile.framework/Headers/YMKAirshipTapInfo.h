#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKAirshipTapInfo : NSObject

/**
 * Panorama id of the tapped airship. The id may be used to open
 * panorama in the panorama player
 */
@property (nonatomic, readonly, nonnull) NSString *panoramaId;


+ (nonnull YMKAirshipTapInfo *)airshipTapInfoWithPanoramaId:(nonnull NSString *)panoramaId;


@end
