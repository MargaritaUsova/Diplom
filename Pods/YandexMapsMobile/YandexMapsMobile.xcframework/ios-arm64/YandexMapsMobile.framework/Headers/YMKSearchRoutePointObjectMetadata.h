#import <YandexMapsMobile/YMKDirection.h>
#import <YandexMapsMobile/YMKPoint.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * An entrance to a building
 */
YRT_EXPORT @interface YMKSearchEntrance : NSObject

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *name;

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKPoint *point;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDirection *direction;


+ (nonnull YMKSearchEntrance *)entranceWithName:(nullable NSString *)name
                                          point:(nonnull YMKPoint *)point
                                      direction:(nullable YMKDirection *)direction;


@end
