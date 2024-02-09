#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * Description to display.
 */
YRT_EXPORT @interface YMKDrivingDescription : NSObject

/**
 * How to get a description.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *via;


+ (nonnull YMKDrivingDescription *)descriptionWithVia:(nullable NSString *)via;


@end
