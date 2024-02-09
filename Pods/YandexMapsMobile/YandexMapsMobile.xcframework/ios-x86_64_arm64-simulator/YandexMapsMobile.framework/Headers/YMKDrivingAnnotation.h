#import <YandexMapsMobile/YMKDrivingAction.h>
#import <YandexMapsMobile/YMKDrivingLandmark.h>
#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * The identifier of the annotation scheme.
 */
typedef NS_ENUM(NSUInteger, YMKDrivingAnnotationSchemeID) {
    /**
     * Small annotation.
     */
    YMKDrivingAnnotationSchemeIDSmall,
    /**
     * Medium annotation.
     */
    YMKDrivingAnnotationSchemeIDMedium,
    /**
     * Large annotation.
     */
    YMKDrivingAnnotationSchemeIDLarge,
    /**
     * Highway annotation.
     */
    YMKDrivingAnnotationSchemeIDHighway
};

/**
 * The length of the U-turn.
 */
YRT_EXPORT @interface YMKDrivingUturnMetadata : NSObject

/**
 * The length оf the turn.
 */
@property (nonatomic, readonly) double length;


+ (nonnull YMKDrivingUturnMetadata *)uturnMetadataWithLength:( double)length;


@end

/**
 * The number of the exit for leaving the roundabout.
 */
YRT_EXPORT @interface YMKDrivingLeaveRoundaboutMetadata : NSObject

/**
 * The exit number.
 */
@property (nonatomic, readonly) NSUInteger exitNumber;


+ (nonnull YMKDrivingLeaveRoundaboutMetadata *)leaveRoundaboutMetadataWithExitNumber:( NSUInteger)exitNumber;


@end

/**
 * Information about an action.
 */
YRT_EXPORT @interface YMKDrivingActionMetadata : NSObject

/**
 * The length of the U-turn.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingUturnMetadata *uturnMetadata;

/**
 * The number of the exit for leaving the roundabout.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingLeaveRoundaboutMetadata *leaveRoundaboutMetadada;


+ (nonnull YMKDrivingActionMetadata *)actionMetadataWithUturnMetadata:(nullable YMKDrivingUturnMetadata *)uturnMetadata
                                              leaveRoundaboutMetadada:(nullable YMKDrivingLeaveRoundaboutMetadata *)leaveRoundaboutMetadada;


@end

/**
 * The description of the object.
 */
YRT_EXPORT @interface YMKDrivingToponymPhrase : NSObject

/**
 * The string containing the description.
 */
@property (nonatomic, readonly, nonnull) NSString *text;


+ (nonnull YMKDrivingToponymPhrase *)toponymPhraseWithText:(nonnull NSString *)text;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingHDAnnotation : NSObject

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKLinearRing *actionArea;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKPolyline *trajectory;


+ (nonnull YMKDrivingHDAnnotation *)hDAnnotationWithActionArea:(nullable YMKLinearRing *)actionArea
                                                    trajectory:(nullable YMKPolyline *)trajectory;


@end

/**
 * The annotation that is displayed on the map.
 */
YRT_EXPORT @interface YMKDrivingAnnotation : NSObject

/**
 * Driver action.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSNumber *action;

/**
 * The toponym of the location.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *toponym;

/**
 * Description text to display.
 */
@property (nonatomic, readonly, nonnull) NSString *descriptionText;

/**
 * Action metadata.
 */
@property (nonatomic, readonly, nonnull) YMKDrivingActionMetadata *actionMetadata;

/**
 * Significant landmarks.
 */
@property (nonatomic, readonly, nonnull) NSArray<NSNumber *> *landmarks;

/**
 * The description of the object.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingToponymPhrase *toponymPhrase;

/**
 * Polygon maneuver.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingHDAnnotation *hdAnnotation;


+ (nonnull YMKDrivingAnnotation *)annotationWithAction:(nullable NSNumber *)action
                                               toponym:(nullable NSString *)toponym
                                       descriptionText:(nonnull NSString *)descriptionText
                                        actionMetadata:(nonnull YMKDrivingActionMetadata *)actionMetadata
                                             landmarks:(nonnull NSArray<NSNumber *> *)landmarks
                                         toponymPhrase:(nullable YMKDrivingToponymPhrase *)toponymPhrase
                                          hdAnnotation:(nullable YMKDrivingHDAnnotation *)hdAnnotation;


@end
