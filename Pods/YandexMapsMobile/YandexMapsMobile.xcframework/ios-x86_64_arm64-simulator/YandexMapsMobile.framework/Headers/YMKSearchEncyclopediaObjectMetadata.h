#import <YandexMapsMobile/YMKAttribution.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Snippet with encyclopedia data.
 */
YRT_EXPORT @interface YMKSearchEncyclopediaObjectMetadata : NSObject

/**
 * Encyclopedia article title.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *title;

/**
 * Encyclopedia article body.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *description;

/**
 * Attribution information.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKAttribution *attribution;


+ (nonnull YMKSearchEncyclopediaObjectMetadata *)encyclopediaObjectMetadataWithTitle:(nullable NSString *)title
                                                                         description:(nullable NSString *)description
                                                                         attribution:(nullable YMKAttribution *)attribution;


@end
