#import <YandexMapsMobile/YMKDrivingAnnotation.h>
#import <YandexMapsMobile/YMKDrivingDirectionSigns.h>
#import <YandexMapsMobile/YMKDrivingFerry.h>
#import <YandexMapsMobile/YMKDrivingFordCrossing.h>
#import <YandexMapsMobile/YMKDrivingJamSegment.h>
#import <YandexMapsMobile/YMKDrivingLane.h>
#import <YandexMapsMobile/YMKDrivingRailwayCrossing.h>
#import <YandexMapsMobile/YMKDrivingStandingSegment.h>
#import <YandexMapsMobile/YMKDrivingTollRoad.h>
#import <YandexMapsMobile/YMKDrivingVehicleRestrictions.h>
#import <YandexMapsMobile/YMKDrivingWeight.h>
#import <YandexMapsMobile/YMKGeometry.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawSpeedLimit : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSInteger count;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSNumber *speed;


+ (nonnull YMKDrivingRawSpeedLimit *)rawSpeedLimitWithCount:( NSInteger)count
                                                      speed:(nullable NSNumber *)speed;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawSpeedLimits : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawSpeedLimit *> *speedLimits;


+ (nonnull YMKDrivingRawSpeedLimits *)rawSpeedLimitsWithSpeedLimits:(nonnull NSArray<YMKDrivingRawSpeedLimit *> *)speedLimits;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawAnnotationScheme : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSInteger count;

/**
 * Undocumented
 */
@property (nonatomic, readonly) YMKDrivingAnnotationSchemeID schemeId;


+ (nonnull YMKDrivingRawAnnotationScheme *)rawAnnotationSchemeWithCount:( NSInteger)count
                                                               schemeId:( YMKDrivingAnnotationSchemeID)schemeId;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawAnnotationSchemes : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawAnnotationScheme *> *schemes;


+ (nonnull YMKDrivingRawAnnotationSchemes *)rawAnnotationSchemesWithSchemes:(nonnull NSArray<YMKDrivingRawAnnotationScheme *> *)schemes;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawLaneSign : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingLane *> *lanes;


+ (nonnull YMKDrivingRawLaneSign *)rawLaneSignWithPosition:( NSUInteger)position
                                                     lanes:(nonnull NSArray<YMKDrivingLane *> *)lanes;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRestrictedEntry : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;


+ (nonnull YMKDrivingRawRestrictedEntry *)rawRestrictedEntryWithPosition:( NSUInteger)position;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawTrafficLight : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;


+ (nonnull YMKDrivingRawTrafficLight *)rawTrafficLightWithPosition:( NSUInteger)position;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRestrictedTurn : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;


+ (nonnull YMKDrivingRawRestrictedTurn *)rawRestrictedTurnWithPosition:( NSUInteger)position;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawLaneSigns : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawLaneSign *> *laneSigns;


+ (nonnull YMKDrivingRawLaneSigns *)rawLaneSignsWithLaneSigns:(nonnull NSArray<YMKDrivingRawLaneSign *> *)laneSigns;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawDirectionSign : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSNumber *direction;

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingDirectionSignItem *> *items;


+ (nonnull YMKDrivingRawDirectionSign *)rawDirectionSignWithPosition:( NSUInteger)position
                                                           direction:(nullable NSNumber *)direction
                                                               items:(nonnull NSArray<YMKDrivingDirectionSignItem *> *)items;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawDirectionSigns : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawDirectionSign *> *signs;


+ (nonnull YMKDrivingRawDirectionSigns *)rawDirectionSignsWithSigns:(nonnull NSArray<YMKDrivingRawDirectionSign *> *)signs;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRestrictedEntries : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawRestrictedEntry *> *restrictedEntries;


+ (nonnull YMKDrivingRawRestrictedEntries *)rawRestrictedEntriesWithRestrictedEntries:(nonnull NSArray<YMKDrivingRawRestrictedEntry *> *)restrictedEntries;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawTrafficLights : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawTrafficLight *> *trafficLights;


+ (nonnull YMKDrivingRawTrafficLights *)rawTrafficLightsWithTrafficLights:(nonnull NSArray<YMKDrivingRawTrafficLight *> *)trafficLights;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawCheckpoint : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;


+ (nonnull YMKDrivingRawCheckpoint *)rawCheckpointWithPosition:( NSUInteger)position;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawCheckpoints : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawCheckpoint *> *checkpoints;


+ (nonnull YMKDrivingRawCheckpoints *)rawCheckpointsWithCheckpoints:(nonnull NSArray<YMKDrivingRawCheckpoint *> *)checkpoints;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRestrictedTurns : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawRestrictedTurn *> *restrictedTurns;


+ (nonnull YMKDrivingRawRestrictedTurns *)rawRestrictedTurnsWithRestrictedTurns:(nonnull NSArray<YMKDrivingRawRestrictedTurn *> *)restrictedTurns;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawJams : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingJamSegment *> *segments;


+ (nonnull YMKDrivingRawJams *)rawJamsWithSegments:(nonnull NSArray<YMKDrivingJamSegment *> *)segments;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawTollRoads : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingTollRoad *> *tollRoads;


+ (nonnull YMKDrivingRawTollRoads *)rawTollRoadsWithTollRoads:(nonnull NSArray<YMKDrivingTollRoad *> *)tollRoads;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawUnpavedRoad : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSInteger dummy;


+ (nonnull YMKDrivingRawUnpavedRoad *)rawUnpavedRoadWithDummy:( NSInteger)dummy;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawInPoorConditionRoad : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSInteger dummy;


+ (nonnull YMKDrivingRawInPoorConditionRoad *)rawInPoorConditionRoadWithDummy:( NSInteger)dummy;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRuggedRoad : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKSubpolyline *position;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawUnpavedRoad *unpaved;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawInPoorConditionRoad *inPoorCondition;


+ (nonnull YMKDrivingRawRuggedRoad *)rawRuggedRoadWithPosition:(nonnull YMKSubpolyline *)position
                                                       unpaved:(nullable YMKDrivingRawUnpavedRoad *)unpaved
                                               inPoorCondition:(nullable YMKDrivingRawInPoorConditionRoad *)inPoorCondition;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRuggedRoads : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawRuggedRoad *> *ruggedRoads;


+ (nonnull YMKDrivingRawRuggedRoads *)rawRuggedRoadsWithRuggedRoads:(nonnull NSArray<YMKDrivingRawRuggedRoad *> *)ruggedRoads;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawFordCrossings : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingFordCrossing *> *fordCrossings;


+ (nonnull YMKDrivingRawFordCrossings *)rawFordCrossingsWithFordCrossings:(nonnull NSArray<YMKDrivingFordCrossing *> *)fordCrossings;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawFerries : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingFerry *> *ferries;


+ (nonnull YMKDrivingRawFerries *)rawFerriesWithFerries:(nonnull NSArray<YMKDrivingFerry *> *)ferries;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRailwayCrossing : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;

/**
 * Undocumented
 */
@property (nonatomic, readonly) YMKDrivingRailwayCrossingType type;


+ (nonnull YMKDrivingRawRailwayCrossing *)rawRailwayCrossingWithPosition:( NSUInteger)position
                                                                    type:( YMKDrivingRailwayCrossingType)type;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawRailwayCrossings : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawRailwayCrossing *> *railwayCrossings;


+ (nonnull YMKDrivingRawRailwayCrossings *)rawRailwayCrossingsWithRailwayCrossings:(nonnull NSArray<YMKDrivingRawRailwayCrossing *> *)railwayCrossings;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawPedestrianCrossing : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;


+ (nonnull YMKDrivingRawPedestrianCrossing *)rawPedestrianCrossingWithPosition:( NSUInteger)position;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawPedestrianCrossings : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawPedestrianCrossing *> *pedestrianCrossings;


+ (nonnull YMKDrivingRawPedestrianCrossings *)rawPedestrianCrossingsWithPedestrianCrossings:(nonnull NSArray<YMKDrivingRawPedestrianCrossing *> *)pedestrianCrossings;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawSpeedBump : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger position;


+ (nonnull YMKDrivingRawSpeedBump *)rawSpeedBumpWithPosition:( NSUInteger)position;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawSpeedBumps : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRawSpeedBump *> *speedBumps;


+ (nonnull YMKDrivingRawSpeedBumps *)rawSpeedBumpsWithSpeedBumps:(nonnull NSArray<YMKDrivingRawSpeedBump *> *)speedBumps;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawStandingSegments : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingStandingSegment *> *standingSegments;


+ (nonnull YMKDrivingRawStandingSegments *)rawStandingSegmentsWithStandingSegments:(nonnull NSArray<YMKDrivingStandingSegment *> *)standingSegments;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawVehicleRestrictions : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingRoadVehicleRestriction *> *roadRestrictions;

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKDrivingManoeuvreVehicleRestriction *> *manoeuvreRestrictions;


+ (nonnull YMKDrivingRawVehicleRestrictions *)rawVehicleRestrictionsWithRoadRestrictions:(nonnull NSArray<YMKDrivingRoadVehicleRestriction *> *)roadRestrictions
                                                                   manoeuvreRestrictions:(nonnull NSArray<YMKDrivingManoeuvreVehicleRestriction *> *)manoeuvreRestrictions;


@end

/**
 * Undocumented
 */
YRT_EXPORT @interface YMKDrivingRawSectionMetadata : NSObject

/**
 * Undocumented
 */
@property (nonatomic, readonly) NSUInteger legIndex;

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKDrivingWeight *weight;

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) YMKDrivingAnnotation *annotation;

/**
 * Undocumented
 */
@property (nonatomic, readonly, nonnull) NSArray<NSNumber *> *viaPointPositions;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawSpeedLimits *speedLimits;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawAnnotationSchemes *annotationSchemes;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawLaneSigns *laneSigns;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawDirectionSigns *directionSigns;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawRestrictedEntries *restrictedEntries;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawTrafficLights *trafficLights;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawJams *jams;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawTollRoads *tollRoads;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawRuggedRoads *ruggedRoads;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawRestrictedTurns *restrictedTurns;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawStandingSegments *standingSegments;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawVehicleRestrictions *vehicleRestrictions;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawFordCrossings *fordCrossings;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawFerries *ferries;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawRailwayCrossings *railwayCrossings;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawPedestrianCrossings *pedestrianCrossings;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawSpeedBumps *speedBumps;

/**
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKDrivingRawCheckpoints *checkpoints;


+ (nonnull YMKDrivingRawSectionMetadata *)rawSectionMetadataWithLegIndex:( NSUInteger)legIndex
                                                                  weight:(nonnull YMKDrivingWeight *)weight
                                                              annotation:(nonnull YMKDrivingAnnotation *)annotation
                                                       viaPointPositions:(nonnull NSArray<NSNumber *> *)viaPointPositions
                                                             speedLimits:(nullable YMKDrivingRawSpeedLimits *)speedLimits
                                                       annotationSchemes:(nullable YMKDrivingRawAnnotationSchemes *)annotationSchemes
                                                               laneSigns:(nullable YMKDrivingRawLaneSigns *)laneSigns
                                                          directionSigns:(nullable YMKDrivingRawDirectionSigns *)directionSigns
                                                       restrictedEntries:(nullable YMKDrivingRawRestrictedEntries *)restrictedEntries
                                                           trafficLights:(nullable YMKDrivingRawTrafficLights *)trafficLights
                                                                    jams:(nullable YMKDrivingRawJams *)jams
                                                               tollRoads:(nullable YMKDrivingRawTollRoads *)tollRoads
                                                             ruggedRoads:(nullable YMKDrivingRawRuggedRoads *)ruggedRoads
                                                         restrictedTurns:(nullable YMKDrivingRawRestrictedTurns *)restrictedTurns
                                                        standingSegments:(nullable YMKDrivingRawStandingSegments *)standingSegments
                                                     vehicleRestrictions:(nullable YMKDrivingRawVehicleRestrictions *)vehicleRestrictions
                                                           fordCrossings:(nullable YMKDrivingRawFordCrossings *)fordCrossings
                                                                 ferries:(nullable YMKDrivingRawFerries *)ferries
                                                        railwayCrossings:(nullable YMKDrivingRawRailwayCrossings *)railwayCrossings
                                                     pedestrianCrossings:(nullable YMKDrivingRawPedestrianCrossings *)pedestrianCrossings
                                                              speedBumps:(nullable YMKDrivingRawSpeedBumps *)speedBumps
                                                             checkpoints:(nullable YMKDrivingRawCheckpoints *)checkpoints;


@end
