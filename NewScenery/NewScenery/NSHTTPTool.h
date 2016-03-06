//
//  NSHTTPTool.h
//  NewScenery
//
//  Created by mac on 16/1/11.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HomeDataCallBackBlock)(NSArray *bannerData,NSArray *designerData,NSArray *routeListData);
typedef void(^ErorCallBackBlock)(NSError *error);
typedef void(^DataCallBackBlock)(NSArray *data);
@interface NSHTTPTool : NSObject

@property (nonatomic, copy)HomeDataCallBackBlock dataBlock;
@property (nonatomic, copy)ErorCallBackBlock errorBlock;
@property (nonatomic, copy)DataCallBackBlock NormalDataBlock;
//获得主页面内容
+ (void)HomeContentGetNetData:(HomeDataCallBackBlock)block error:(ErorCallBackBlock)error;
//获取搜素网络数据
+ (void)SearchRouteListGetNetDataWithType:(int)type KeyWord:(NSString *)word page:(int)page data:(DataCallBackBlock)block error:(ErorCallBackBlock)error;
//获得活动网络数据
+ (void)ActionGetNetData:(DataCallBackBlock )block error:(ErorCallBackBlock)error;
//获得自定义路线网络数据
+ (void)BeginCustomizedGetNetData:(DataCallBackBlock)block error:(ErorCallBackBlock)error;
//更多设计者
+ (void)MoreDesignerGetNetData:(DataCallBackBlock)block page:(int)page error:(ErorCallBackBlock)error;
//更多路线
+ (void)SpecialRouteListGetNetDatas:(DataCallBackBlock)block special_id:(NSString *)special_id error:(ErorCallBackBlock)error;
//获得设计者详细信息
+ (void)MoreInfoForDesinerGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error;
//获得路线的详细信息
+ (void)MoreInfoForRouteGetNetData:(DataCallBackBlock)block  routeID:(NSString *)routeID error:(ErorCallBackBlock)error;
//获得旅行灵感页面内容
+ (void)SpecialGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error;
//电话服务价格
+ (void)ServiceCanPhoneGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error;
//更多地点列表
+ (void)SpecialPointListGetNetDatas:(DataCallBackBlock)block special_id:(NSString *)special_id error:(ErorCallBackBlock)error;
//获得地点的详细信息
+ (void)SpecialPointInfoGetNetDatas:(DataCallBackBlock)block point_id:(NSString *)point_id error:(ErorCallBackBlock)error;
//见面咨询价格
+ (void)ServiceCanDoorToDoorGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error;
//日程页面获得网络数据
+ (void)DaliysByRouteGetNetDatas:(DataCallBackBlock)block  error:(ErorCallBackBlock)error;
//自定义路线套餐获得网络数据
+ (void)ServicePackageGetNetDatas:(DataCallBackBlock)block  error:(ErorCallBackBlock)error;
//家族app获得网络数据
+ (void)AllMemberGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error;

@end
