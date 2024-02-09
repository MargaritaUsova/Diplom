#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

/**
 * The type of reference.
 */
YRT_EXPORT @interface YMKSearchReferenceType : NSObject

/**
 * Reference ID.
 */
@property (nonatomic, readonly, nonnull) NSString *id;

/**
 * Reference scope.
 */
@property (nonatomic, readonly, nonnull) NSString *scope;


+ (nonnull YMKSearchReferenceType *)referenceTypeWithId:(nonnull NSString *)id
                                                  scope:(nonnull NSString *)scope;


@end

/**
 * Reference metadata information.
 */
YRT_EXPORT @interface YMKSearchReferencesObjectMetadata : NSObject

/**
 * The  list of references.
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKSearchReferenceType *> *references;


+ (nonnull YMKSearchReferencesObjectMetadata *)referencesObjectMetadataWithReferences:(nonnull NSArray<YMKSearchReferenceType *> *)references;


@end
