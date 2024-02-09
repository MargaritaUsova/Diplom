#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKSearchLine : NSObject

/**
 * Name of the line that the nearest stop is on.
 */
@property (nonatomic, readonly, nonnull) NSString *name;


+ (nonnull YMKSearchLine *)lineWithName:(nonnull NSString *)name;


@end
