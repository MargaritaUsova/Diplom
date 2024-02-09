#import <YandexMapsMobile/YMKMasstransitRoute.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * :nodoc:
 * It is not to be used in platform code
 */
YRT_EXPORT @interface YMKSectionMetadataInternal : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKMasstransitSectionMetadata *metadata;

/**
 * Undocumented
 */
@property (nonatomic, readonly) BOOL isPassThroughTransportSection;


+ (nonnull YMKSectionMetadataInternal *)sectionMetadataInternalWithMetadata:(nonnull YMKMasstransitSectionMetadata *)metadata
                                              isPassThroughTransportSection:( BOOL)isPassThroughTransportSection;


@end
