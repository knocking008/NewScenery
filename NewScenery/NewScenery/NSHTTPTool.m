//
//  NSHTTPTool.m
//  NewScenery
//
//  Created by mac on 16/1/11.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSHTTPTool.h"

#import "AFNetworking.h"
#import "NSHeaderFile.h"
#import "UrlStrHeaderFile.h"
@implementation NSHTTPTool
{
    NSMutableArray *daliysByRouteSctionArr;
}
#pragma mark - 获得主页面内容
+ (void)HomeContentGetNetData:(HomeDataCallBackBlock)block error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool HomeContentGetNetData:block error:error];

}
- (void)HomeContentGetNetData:(HomeDataCallBackBlock)block error:(ErorCallBackBlock)error
{
    self.dataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:KHomeContentUrlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //获取banner网络数据
        NSMutableArray *bannerArray = [NSMutableArray new];
        NSDictionary *data = responseObject[@"data"];
        for (NSDictionary *bannerDic in data[@"banner_list"]) {
            NSBannerModel *model = [[NSBannerModel alloc] init];
            [model setValuesForKeysWithDictionary:bannerDic];
            model.special_id = data[@"special_id"];
            [bannerArray addObject:model];
        }
        //获取设计者网络数据
        NSMutableArray *designerArray = [NSMutableArray new];
        for (NSDictionary *tmpDic in data[@"designer_list"]) {
            NSMoreDesigner *model = [[NSMoreDesigner alloc] init];
            [model setValuesForKeysWithDictionary:tmpDic];
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:tmpDic[@"skilled"]];
            model.skill = [tmpArr componentsJoinedByString:@"·"];
            [designerArray addObject:model];
        }
        //获得路线网络路线
        NSMutableArray *routeListArray = [NSMutableArray new];
        for (NSDictionary *routeListDic in data[@"route_list"]) {
            NSMoreRouteListModel *subModel = [[NSMoreRouteListModel alloc] init];
            [subModel setValuesForKeysWithDictionary:routeListDic];
            NSArray *citysArr = routeListDic[@"citys"];
            NSMutableArray *citysName = [NSMutableArray new];
            for (NSDictionary *cityDic in citysArr) {
                    NSString *cityName = cityDic[@"place_name"];
                    [citysName addObject:cityName];
                }
            subModel.city = [citysName componentsJoinedByString:@"·"];
            [routeListArray addObject:subModel];
        }
        if (self.dataBlock) {
            self.dataBlock(bannerArray,designerArray,routeListArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}

#pragma mark - 获取搜素网络数据
+ (void)SearchRouteListGetNetDataWithType:(int)type KeyWord:(NSString *)word page:(int)page data:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [[NSHTTPTool alloc] init];
    [tool SearchRouteListGetNetDataWithType:type KeyWord:word page:page data:block error:error];
    
}
- (void)SearchRouteListGetNetDataWithType:(int)type KeyWord:(NSString *)word page:(int)page data:(DataCallBackBlock)block error:(ErorCallBackBlock)error{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    if (word&&word.length!=0) {
    word = [word stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[AFHTTPSessionManager manager]GET:[NSString stringWithFormat:kSearchUrlStr,type,word,page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
         NSMutableArray *tmpArr = [NSMutableArray new];
        if (type == 1) {
            NSArray *dataArr = dataDic[@"route_list"];
            for (NSDictionary *dic in dataArr) {
                NSSearchRouteModel *model = [[NSSearchRouteModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                NSMutableArray *placeTmpArr = [NSMutableArray new];
                for (NSDictionary *place_listDic in dic[@"place_list"]) {
                    NSString *placeStr = place_listDic[@"place_name"];
                    [placeTmpArr addObject:placeStr];
                }
                model.place_li = [placeTmpArr componentsJoinedByString:@"·"];
                [tmpArr addObject:model];
            }
        }else if(type == 2){
            NSArray *dataArr = dataDic[@"designer_list"];
            for (NSDictionary *designerDic in dataArr) {
                NSSearchDesignerModel *searchDesignerModel = [NSSearchDesignerModel new];
                [searchDesignerModel setValuesForKeysWithDictionary:designerDic];
                [tmpArr addObject:searchDesignerModel];
            }
        }else if(type == 3){
            NSArray *dataArr = dataDic[@"point_list"];
            for (NSDictionary *pointDic in dataArr) {
                NSSearchPointModel *searchPointModel = [NSSearchPointModel new];
                [searchPointModel setValuesForKeysWithDictionary:pointDic];
                [tmpArr addObject:searchPointModel];
            }
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(tmpArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
}

#pragma mark - 获得活动网络数据
+ (void)ActionGetNetData:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [[NSHTTPTool alloc] init];
    [tool ActionGetNetData:block error:error];
}
- (void)ActionGetNetData:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:KActionUrlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *data = responseObject[@"data"];
        NSMutableArray *tmpArray = [NSMutableArray new];
        for (NSDictionary *tmpDic in data) {
            NSActionModel *model = [NSActionModel new];
            [model setValuesForKeysWithDictionary:tmpDic];
            [tmpArray addObject:model];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(tmpArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 获得自定义路线网络数据

+ (void)BeginCustomizedGetNetData:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [[NSHTTPTool alloc] init];
    [tool BeginCustomizedGetNetData:block error:error];
}
- (void)BeginCustomizedGetNetData:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:KBeginCustomizedUrlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArr = responseObject[@"data"];

        NSMutableArray *tmpArr = [NSMutableArray new];
        for (NSDictionary *tmpDic in dataArr) {
            NSArray *listArr = tmpDic[@"list"];
            NSString *tmpStr = tmpDic[@"title"];
            NSMutableArray *dataModelArr = [NSMutableArray new];
            for (NSDictionary *placDic in listArr) {
                NSPlaceModel *model = [[NSPlaceModel alloc]init];
                [model setValuesForKeysWithDictionary:placDic];
                model.locationTypt = tmpStr;
                [dataModelArr addObject:model];
            }
            [tmpArr addObject:dataModelArr];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(tmpArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}

#pragma mark - 更多设计者
+ (void)MoreDesignerGetNetData:(DataCallBackBlock)block page:(int)page error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [[NSHTTPTool alloc] init];
    [tool MoreDesignerGetNetData:block page:page error:error];
}
- (void)MoreDesignerGetNetData:(DataCallBackBlock)block page:(int)page error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KMoreDesignerUrlStr,page] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dataArray = [NSMutableArray new];
        for (NSDictionary *tmpDic in responseObject[@"data"]) {
            NSMoreDesigner *model = [[NSMoreDesigner alloc] init];
            [model setValuesForKeysWithDictionary:tmpDic];
            NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:tmpDic[@"skilled"]];
            model.skill = [tmpArr componentsJoinedByString:@"·"];
            [dataArray addObject:model];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 更多路线
+ (void)SpecialRouteListGetNetDatas:(DataCallBackBlock)block special_id:(NSString *)special_id error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool SpecialRouteListGetNetDatas:block special_id:special_id error:error];
}
- (void)SpecialRouteListGetNetDatas:(DataCallBackBlock)block special_id:(NSString *)special_id error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock =error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KMoreSpecialdetailUreStr,[special_id intValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dataArray = [NSMutableArray new];
        NSDictionary *dataDic = responseObject[@"data"];
        NSMoreRouteBannerModel *model = [[NSMoreRouteBannerModel alloc] init];
        [model setValuesForKeysWithDictionary:dataDic];
        [dataArray addObject:model];
        NSArray *sublistArr = dataDic[@"sublist"];
        for (NSDictionary *tmpDic in sublistArr) {
            NSMoreRouteListModel *subModel = [[NSMoreRouteListModel alloc] init];
            [subModel setValuesForKeysWithDictionary:tmpDic];
            NSArray *citysArr = tmpDic[@"citys"];
            NSMutableArray *citysName = [NSMutableArray new];
            for (NSDictionary *cityDic in citysArr) {
                NSString *cityName = cityDic[@"place_name"];
                [citysName addObject:cityName];
            }
            subModel.city = [citysName componentsJoinedByString:@"·"];
            [dataArray addObject:subModel];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 获得设计者详细信息
+ (void)MoreInfoForDesinerGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool MoreInfoForDesinerGetNetDatas:block desinerID:desinerID error:error];
}
- (void)MoreInfoForDesinerGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KMoreInfoForDesignerUrlStr,[desinerID intValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSMutableArray *dataArr = [NSMutableArray new];
        NSDesignerBaseInfoModel *designerBasemodel = [[NSDesignerBaseInfoModel alloc] init];
        [designerBasemodel setValuesForKeysWithDictionary:dataDic];
        NSArray *skilledArr = dataDic[@"skilled"];
        designerBasemodel.skill = [skilledArr componentsJoinedByString:@"·"];
        
        if ([dataDic[@"route_avg"] isKindOfClass:[NSString class]]) {
            designerBasemodel.route_av = dataDic[@"route_avg"];
            designerBasemodel.service_av = dataDic[@"service_avg"];
            designerBasemodel.efficiency_av = dataDic[@"efficiency_avg"];
        }else{
            designerBasemodel.route_av =  [NSString stringWithFormat:@"%@",dataDic[@"route_avg"]];
            designerBasemodel.service_av = [NSString stringWithFormat:@"%@",dataDic[@"service_avg"]];
            designerBasemodel.efficiency_av = [NSString stringWithFormat:@"%@",dataDic[@"efficiency_avg"]];
        }
        
        [dataArr addObject:designerBasemodel];
        //--------------route_list
        NSArray *route_list = dataDic[@"route_list"];
        NSMutableArray *route_listTmpArr = [NSMutableArray new];
        for (NSDictionary *routeDic in route_list) {
            NSDesignerWorksModel *designerWorksModel = [NSDesignerWorksModel new];
            [designerWorksModel setValuesForKeysWithDictionary:routeDic];
            NSArray *place_listArr = routeDic[@"place_list"];
            NSMutableArray *place_listTmpArr = [NSMutableArray new];
            for (NSDictionary *placeDic in place_listArr) {
                NSString *placeName = placeDic[@"place_name"];
                [place_listTmpArr addObject:placeName];
            }
            designerWorksModel.placeList = [place_listTmpArr componentsJoinedByString:@"·"];
            [route_listTmpArr addObject:designerWorksModel];
        }
        [dataArr addObject:route_listTmpArr];
        //--------------appraise_list
        NSArray *appraise_listArr = dataDic[@"appraise_list"];
        NSMutableArray *appraise_listTmpArr = [NSMutableArray new];
        for (NSDictionary *appraiseDic in appraise_listArr) {
            NSAppraise_listForDesignerModel *appraise_listForDesignerModel = [NSAppraise_listForDesignerModel new];
            [appraise_listForDesignerModel setValuesForKeysWithDictionary:appraiseDic];
            [appraise_listTmpArr addObject:appraise_listForDesignerModel];
        }
        [dataArr addObject:appraise_listTmpArr];
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 获得路线的详细信息
+ (void)MoreInfoForRouteGetNetData:(DataCallBackBlock)block routeID:(NSString *)routeID error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool MoreInfoForRouteGetNetData:block routeID:routeID error:error];
}
- (void)MoreInfoForRouteGetNetData:(DataCallBackBlock)block routeID:(NSString *)routeID error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KMoreInfoForRouteUrlStr,[routeID intValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSMutableArray *dataArr = [NSMutableArray new];
        //banner get net datas
        NSRouteBaseInfoModel *routeBaseInfoModel = [[NSRouteBaseInfoModel alloc] init];
        [routeBaseInfoModel setValuesForKeysWithDictionary:dataDic];
        [dataArr addObject:routeBaseInfoModel];
        //daliy get net datas
        NSArray *daysArr = dataDic[@"days"];
        NSMutableArray *tmpDayArr = [NSMutableArray new];
        for (NSDictionary *dayDic in daysArr) {
            NSMutableArray *dayArr = [NSMutableArray new];
            for (NSDictionary *daliyDic in dayDic[@"daliy"]) {
                if ([daliyDic[@"daliy_type"] isEqualToString:@"point"]) {
                    NSRouteDaysModel  *routeDaysModel = [NSRouteDaysModel new];
                    [routeDaysModel setValuesForKeysWithDictionary:daliyDic];
                     [dayArr addObject:routeDaysModel];
                }else if([daliyDic[@"daliy_type"] isEqualToString:@"traffic"]){
                    NSRouteTrafficModel *routeTrafficModel = [NSRouteTrafficModel new];
                    [routeTrafficModel setValuesForKeysWithDictionary:daliyDic];
                     [dayArr addObject:routeTrafficModel];
                }
            }
            [tmpDayArr addObject:dayArr];
        }
        [dataArr addObject:tmpDayArr];
        //service
        NSMutableArray *serviceArr = [NSMutableArray new];
        for (NSDictionary *serviceDic in dataDic[@"service"]) {
            NSRouteServiceModel *routeServiceModel = [NSRouteServiceModel new];
            [routeServiceModel setValuesForKeysWithDictionary:serviceDic];
            [serviceArr addObject:routeServiceModel];
        }
        [dataArr addObject:serviceArr];
        //route_overview
        NSMutableArray *route_overviewArr = [NSMutableArray new];
        for (NSDictionary *route_overViewDic in dataDic[@"route_overview"]) {
            NSRoute_overviewModel *route_overviewModel = [NSRoute_overviewModel new];
            [route_overviewModel setValuesForKeysWithDictionary:route_overViewDic];
            [route_overviewArr addObject:route_overviewModel];
        }
        [dataArr addObject:route_overviewArr];
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}

#pragma mark - 获得旅行灵感页面内容
+ (void)SpecialGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool SpecialGetNetDatas:block error:error];
}
- (void)SpecialGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:KSpecialUrlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dataArr = [NSMutableArray new];
        for (NSDictionary *subDic in responseObject[@"data"]) {
            NSGetspecialModel *model = [NSGetspecialModel new];
            [model setValuesForKeysWithDictionary:subDic];
            [dataArr addObject:model];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}

#pragma mark - 电话服务价格
+ (void)ServiceCanPhoneGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool ServiceCanPhoneGetNetDatas:block desinerID:desinerID error:error];
}
- (void)ServiceCanPhoneGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KCanPhoneUrlStr,[desinerID intValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *dataArr = [NSMutableArray new];
        for (NSDictionary *tmpDic in responseObject[@"data"]) {
            NSCanPhoneModel *model = [NSCanPhoneModel new];
            [model setValuesForKeysWithDictionary:tmpDic];
            [dataArr addObject:model];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArr);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 更多地点列表
+ (void)SpecialPointListGetNetDatas:(DataCallBackBlock)block special_id:(NSString *)special_id error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool SpecialPointListGetNetDatas:block special_id:special_id error:error];
}
- (void)SpecialPointListGetNetDatas:(DataCallBackBlock)block special_id:(NSString *)special_id error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KMoreSpecialdetailUreStr,[special_id intValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSMutableArray *dataArray = [NSMutableArray new];
        //banner
        NSPointListBanner *banner = [NSPointListBanner new];
        [banner setValuesForKeysWithDictionary:dataDic];
        [dataArray addObject:banner];
        //pointList
        NSArray *sublistArr = dataDic[@"sublist"];
       
        for (NSDictionary *pointDic in sublistArr) {
            NSPointListModel *pointListModel = [NSPointListModel new];
            [pointListModel setValuesForKeysWithDictionary:pointDic];
            [dataArray addObject:pointListModel];
        }
        
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 获得地点的详细信息
+ (void)SpecialPointInfoGetNetDatas:(DataCallBackBlock)block point_id:(NSString *)point_id error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool SpecialPointInfoGetNetDatas:block point_id:point_id error:error];
}
- (void)SpecialPointInfoGetNetDatas:(DataCallBackBlock)block point_id:(NSString *)point_id error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KPointInfoUrlStr,[point_id intValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSMutableArray *dataArray = [NSMutableArray new];
        //pointInfo
        NSPointInfoModel *pointInfoModel = [NSPointInfoModel new];
        [pointInfoModel setValuesForKeysWithDictionary:dataDic];
        pointInfoModel.img = dataDic[@"imgs"];
        [dataArray addObject:pointInfoModel];
        //authorInfos
        NSPointAuthorInfoModel *pointAuthorInfoModel = [NSPointAuthorInfoModel new];
        [pointAuthorInfoModel setValuesForKeysWithDictionary:dataDic[@"authorInfo"]];
        [dataArray addObject:pointAuthorInfoModel];
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 见面咨询价格
+ (void)ServiceCanDoorToDoorGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error
{
    NSHTTPTool *tool = [NSHTTPTool new];
    [tool ServiceCanDoorToDoorGetNetDatas:block desinerID:desinerID error:error];
}
- (void)ServiceCanDoorToDoorGetNetDatas:(DataCallBackBlock)block desinerID:(NSString *)desinerID error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:KCanDoorToDoorurlStr,[desinerID intValue]] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSMutableArray *dataArray = [NSMutableArray new];
        //价格列表
        NSArray *designer_packageArr = dataDic[@"designer_package"];
        NSMutableArray *designer_packageTmpArr = [NSMutableArray new];
        for (NSDictionary *designer_packageDic in designer_packageArr) {
            NSCanDoorToDoorModel *canDoorToDoorModel = [NSCanDoorToDoorModel new];
            [canDoorToDoorModel setValuesForKeysWithDictionary:designer_packageDic];
            [designer_packageTmpArr addObject:canDoorToDoorModel];
        }
        [dataArray addObject:designer_packageTmpArr];
        //见面地区
        NSDictionary *tmpDic = [dataDic[@"service_area"] firstObject];
        
        NSArray *sublistArr = tmpDic[@"sublist"];
        NSMutableArray *sublistTmpArr = [NSMutableArray new];
        for (NSDictionary *areaDic in sublistArr) {
            NSService_areaSublistModel *service_areaSublistModel = [NSService_areaSublistModel new];
            [service_areaSublistModel setValuesForKeysWithDictionary:areaDic];
            [sublistTmpArr addObject:service_areaSublistModel];
        }
        [dataArray addObject:sublistTmpArr];
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}

#pragma mark - 日程页面获得网络数据
+ (void)DaliysByRouteGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    [[NSHTTPTool new] DaliysByRouteGetNetDatas:block error:error];
}
- (void)DaliysByRouteGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:KDaliysByRoute parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArr = responseObject[@"data"];
        NSDictionary *dataDic = [dataArr firstObject];
        NSMutableArray *backArray = [NSMutableArray new];
        NSDaliysBannaerModel *daliysBannaerModel = [NSDaliysBannaerModel new];
        [daliysBannaerModel setValuesForKeysWithDictionary:dataDic];
        [backArray addObject:daliysBannaerModel];
        
        int sectionIndex = 0;
        for (NSDictionary *daliysDic in dataDic[@"daliys"]) {
            if ([daliysDic[@"day_index"] intValue] > sectionIndex) {
                if (daliysByRouteSctionArr&&daliysByRouteSctionArr.count!=0) {
                    [backArray addObject:daliysByRouteSctionArr];
                }
                daliysByRouteSctionArr = [NSMutableArray new];
                sectionIndex = [daliysDic[@"day_index"] intValue];
            }
            if ([daliysDic[@"daliy_type"] isEqualToString:@"point"]) {
                NSDaliysPointModel *daliysPointModel = [NSDaliysPointModel new];
                [daliysPointModel setValuesForKeysWithDictionary:daliysDic];
                [daliysByRouteSctionArr addObject:daliysPointModel];
            }else if ([daliysDic[@"daliy_type"] isEqualToString:@"traffic"]){
                NSDaliysTrafficModel *daliysTrafficModel = [NSDaliysTrafficModel new];
                [daliysTrafficModel setValuesForKeysWithDictionary:daliysDic];
                [daliysByRouteSctionArr addObject:daliysTrafficModel];
            }
        }
        [backArray addObject:daliysByRouteSctionArr];
        
        if (self.NormalDataBlock) {
            self.NormalDataBlock(backArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 自定义路线套餐获得网络数据
+ (void)ServicePackageGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    [[NSHTTPTool new] ServicePackageGetNetDatas:block error:error];
}
- (void)ServicePackageGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:KServicePackageUrlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArray = responseObject[@"data"][@"package_list"];
        NSMutableArray *callArray = [NSMutableArray new];
        for (NSDictionary *tmpDic in dataArray) {
            NSServicePackageModel *ServicePackageModel = [NSServicePackageModel new];
            [ServicePackageModel setValuesForKeysWithDictionary:tmpDic];
            [callArray addObject:ServicePackageModel];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(callArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
#pragma mark - 家族成员获取网络数据
+ (void)AllMemberGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error
{
    [[NSHTTPTool new] AllMemberGetNetDatas:block error:error];
}
- (void)AllMemberGetNetDatas:(DataCallBackBlock)block error:(ErorCallBackBlock)error{
    self.NormalDataBlock = block;
    self.errorBlock = error;
    [[AFHTTPSessionManager manager] GET:KAllMemberUrlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *dataCallBalckArray = [NSMutableArray new];
        for (NSDictionary *dataDic in dataArray) {
            NSAllMemberModel *AllMemberModel = [NSAllMemberModel new];
            [AllMemberModel setValuesForKeysWithDictionary:dataDic];
            [dataCallBalckArray addObject:AllMemberModel];
        }
        if (self.NormalDataBlock) {
            self.NormalDataBlock(dataCallBalckArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.errorBlock) {
            self.errorBlock(error);
        }
    }];
}
@end
