//
//  UrlStrHeaderFile.h
//  NewScenery
//
//  Created by mac on 16/1/22.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#ifndef NewScenery_UrlStrHeaderFile_h
#define NewScenery_UrlStrHeaderFile_h
//页面内容：
#define KHomeContentUrlStr  @"http://m.zhinanmao.com/tripapi/indexData?system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//搜索 参数：type=1  w=%@ page=%d
#define kSearchUrlStr @"http://m.zhinanmao.com/tripapi/search?type=%d&w=%@&page=%d&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//活动
#define KActionUrlStr @"http://m.zhinanmao.com/tripapi/news?system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//开始定制路线
#define KBeginCustomizedUrlStr @"http://m.zhinanmao.com/tripapi/destination?system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//更多设计者 参数：page=%d
#define KMoreDesignerUrlStr @"http://m.zhinanmao.com/tripapi/designerList?page=%d&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//更多特别路线、地点信息 参数 : special_id=55
#define KMoreSpecialdetailUreStr @"http://m.zhinanmao.com/tripapi/specialdetail?special_id=%d&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"

//设计者详细信息 参数:uid = %d
#define KMoreInfoForDesignerUrlStr @"http://m.zhinanmao.com/tripapi/designer?uid=%d&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//路线的详细信息 参数:route_id=2202
#define KMoreInfoForRouteUrlStr @"http://m.zhinanmao.com/tripapi/route?route_id=%d&order_id=&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//获得旅行灵感页面内容
#define KSpecialUrlStr @"http://m.zhinanmao.com/tripapi/getspecial?system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//获得地点列表内容 参数:
#define KPointListUrlStr @"http://m.zhinanmao.com/tripapi/specialdetail?special_id=211&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//电话服务价格 参数：designer_id=3856
#define KCanPhoneUrlStr @"http://m.zhinanmao.com/tripapi/designerPackage?designer_id=%d&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//地点的详细信息 参数:point_id=143054
#define KPointInfoUrlStr @"http://m.zhinanmao.com/tripapi/point?point_id=%d&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//见面咨询价格 参数:designer_id=3856
#define KCanDoorToDoorurlStr @"http://m.zhinanmao.com/tripapi/initDoorToDoor?designer_id=%d&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//日程页面获得网络数据
#define KDaliysByRoute @"http://m.zhinanmao.com/tripapi/daliysByRoute?system=iPhone&system_version=9.2.1&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//自定义路线套餐获得网络数据
#define KServicePackageUrlStr @"http://m.zhinanmao.com/tripapi/servicePackage?system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
//获得家族成员appUrl
#define KAllMemberUrlStr @"http://m.zhinanmao.com/tripapi/znmApps?system=iPhone&system_version=9.2.1&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"

#endif
