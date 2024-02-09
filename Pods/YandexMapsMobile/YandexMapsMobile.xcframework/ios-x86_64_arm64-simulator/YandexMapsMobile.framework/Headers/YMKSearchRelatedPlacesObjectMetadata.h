#import <YandexMapsMobile/YMKSearchRelatedPlaces.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Snippet data to get related places info.
 */
YRT_EXPORT @interface YMKSearchRelatedPlacesObjectMetadata : NSObject

/**
 * List of similar places.
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKSearchPlaceInfo *> *similarPlaces;


+ (nonnull YMKSearchRelatedPlacesObjectMetadata *)relatedPlacesObjectMetadataWithSimilarPlaces:(nonnull NSArray<YMKSearchPlaceInfo *> *)similarPlaces;


@end
