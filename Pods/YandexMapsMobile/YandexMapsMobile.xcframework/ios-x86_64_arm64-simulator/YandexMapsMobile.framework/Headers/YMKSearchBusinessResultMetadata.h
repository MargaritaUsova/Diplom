#import <YandexMapsMobile/YMKSearchBusinessFilter.h>
#import <YandexMapsMobile/YMKSearchCategory.h>
#import <YandexMapsMobile/YMKSearchChain.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Common info for business search response.
 */
YRT_EXPORT @interface YMKSearchBusinessResultMetadata : NSObject

/**
 * List of categories (also known as rubrics) present in response.
 * Non-empty list means that the request was treated as a 'category
 * request' by the server (e.g. requests like "where to eat", "cinema",
 * etc.).
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKSearchCategory *> *categories;

/**
 * List of chains present in response. Non-empty list means that the
 * request was treaded as 'chain request' (e.g. "mcdonalds",
 * "starbucks", etc.).
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKSearchChain *> *chains;

/**
 * List of applicable filters.
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKSearchBusinessFilter *> *businessFilters;

/**
 * Collection of filters that probably are of utmost interest to the
 * user.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKSearchFilterSet *importantFilters;


+ (nonnull YMKSearchBusinessResultMetadata *)businessResultMetadataWithCategories:(nonnull NSArray<YMKSearchCategory *> *)categories
                                                                           chains:(nonnull NSArray<YMKSearchChain *> *)chains
                                                                  businessFilters:(nonnull NSArray<YMKSearchBusinessFilter *> *)businessFilters
                                                                 importantFilters:(nullable YMKSearchFilterSet *)importantFilters;


@end
