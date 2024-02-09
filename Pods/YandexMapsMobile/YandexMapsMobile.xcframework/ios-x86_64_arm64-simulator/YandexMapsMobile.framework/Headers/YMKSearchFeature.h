#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

@class YMKSearchFeatureEnumValue;
@class YMKSearchFeatureVariantValue;

/**
 * Describes some common feature of organizations. Can be of three
 * types:
 *
 * - boolean (like on/off switch, as for free Wi-Fi availability).
 *
 * - enumerated (can have multiple values at once, like cuisine types in
 * a cafe).
 *
 * - text (like enumerated but with any strings instead of predefined
 * values).
 */
YRT_EXPORT @interface YMKSearchFeature : NSObject

/**
 * Machine readable feature identifier.
 */
@property (nonatomic, readonly, nonnull) NSString *id;

/**
 * Feature value (depends on feature type).
 */
@property (nonatomic, readonly, nonnull) YMKSearchFeatureVariantValue *value;

/**
 * Human readable localized representation.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *name;

/**
 * Reference to information source providing given feature (see
 * YMKAttribution)
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *aref;


+ (nonnull YMKSearchFeature *)featureWithId:(nonnull NSString *)id
                                      value:(nonnull YMKSearchFeatureVariantValue *)value
                                       name:(nullable NSString *)name
                                       aref:(nullable NSString *)aref;


@end

/**
 * Value for enumerated features.
 */
YRT_EXPORT @interface YMKSearchFeatureEnumValue : NSObject

/**
 * Machine readable value identifier.
 */
@property (nonatomic, readonly, nonnull) NSString *id;

/**
 * Human readable localized representation.
 */
@property (nonatomic, readonly, nonnull) NSString *name;

/**
 * urlTemplate for the image. Available sizes are listed here:
 * http://api.yandex.ru/fotki/doc/format-ref/f-img.xml
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *imageUrlTemplate;


+ (nonnull YMKSearchFeatureEnumValue *)enumValueWithId:(nonnull NSString *)id
                                                  name:(nonnull NSString *)name
                                      imageUrlTemplate:(nullable NSString *)imageUrlTemplate;


@end

/**
 * A variant combining possible feature values.
 */
YRT_EXPORT @interface YMKSearchFeatureVariantValue : NSObject

@property (nonatomic, readonly, nullable) NSNumber *booleanValue;

@property (nonatomic, readonly, nullable) NSArray<NSString *> *textValue;

@property (nonatomic, readonly, nullable) NSArray<YMKSearchFeatureEnumValue *> *enumValue;

+ (nonnull YMKSearchFeatureVariantValue *)variantValueWithBooleanValue:(BOOL)booleanValue;

+ (nonnull YMKSearchFeatureVariantValue *)variantValueWithTextValue:(nonnull NSArray<NSString *> *)textValue;

+ (nonnull YMKSearchFeatureVariantValue *)variantValueWithEnumValue:(nonnull NSArray<YMKSearchFeatureEnumValue *> *)enumValue;

@end


/**
 * Collection of features.
 */
YRT_EXPORT @interface YMKSearchFeatureSet : NSObject

/**
 * IDs for features in the collection.
 */
@property (nonatomic, readonly, nonnull) NSArray<NSString *> *ids;


+ (nonnull YMKSearchFeatureSet *)featureSetWithIds:(nonnull NSArray<NSString *> *)ids;


@end

/**
 * Group of features.
 */
YRT_EXPORT @interface YMKSearchFeatureGroup : NSObject

/**
 * Group name.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *name;

/**
 * IDs for features in the group.
 */
@property (nonatomic, readonly, nonnull) NSArray<NSString *> *ids;


+ (nonnull YMKSearchFeatureGroup *)featureGroupWithName:(nullable NSString *)name
                                                    ids:(nonnull NSArray<NSString *> *)ids;


@end
