#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * Single chain (group of companies) description.
 */
YRT_EXPORT @interface YMKSearchChain : NSObject

/**
 * Chain identifier.
 */
@property (nonatomic, readonly, nonnull) NSString *id;

/**
 * Chain name.
 */
@property (nonatomic, readonly, nonnull) NSString *name;


+ (nonnull YMKSearchChain *)chainWithId:(nonnull NSString *)id
                                   name:(nonnull NSString *)name;


@end
