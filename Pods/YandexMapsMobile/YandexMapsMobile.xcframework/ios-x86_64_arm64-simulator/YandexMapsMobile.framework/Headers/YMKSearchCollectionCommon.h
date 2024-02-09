#import <YandexMapsMobile/YMKImage.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Collection author info.
 */
YRT_EXPORT @interface YMKSearchAuthor : NSObject

/**
 * Author name. E.g. "Афиша"
 */
@property (nonatomic, readonly, nonnull) NSString *name;

/**
 * Additional author description. E.g. "Самые интересные
 * места города".
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *description;

/**
 * Author favicon.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKImage *favicon;

/**
 * URI to get more information about the author.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *uri;


+ (nonnull YMKSearchAuthor *)authorWithName:(nonnull NSString *)name
                                description:(nullable NSString *)description
                                    favicon:(nullable YMKImage *)favicon
                                        uri:(nullable NSString *)uri;


@end

/**
 * Collection description.
 */
YRT_EXPORT @interface YMKSearchCollection : NSObject

/**
 * Collection URI. Enables collection bookmarking and resolving.
 */
@property (nonatomic, readonly, nonnull) NSString *uri;

/**
 * Collection title. E.g. "Вкусные стейки в Москве".
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *title;

/**
 * Additional collection description.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *description;

/**
 * Main image for the collection.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKImage *image;

/**
 * Number of entries in the collection.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSNumber *itemCount;

/**
 * Collection rubric.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *rubric;

/**
 * Author of the collection.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKSearchAuthor *author;

/**
 * Collection SEO name.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *seoname;


+ (nonnull YMKSearchCollection *)collectionWithUri:(nonnull NSString *)uri
                                             title:(nullable NSString *)title
                                       description:(nullable NSString *)description
                                             image:(nullable YMKImage *)image
                                         itemCount:(nullable NSNumber *)itemCount
                                            rubric:(nullable NSString *)rubric
                                            author:(nullable YMKSearchAuthor *)author
                                           seoname:(nullable NSString *)seoname;


@end
