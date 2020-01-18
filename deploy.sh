#!/usr/bin/env bash
#编译+部署order站点

#需要配置如下参数
# 项目路径, 在Execute Shell中配置项目路径, pwd 就可以获得该项目路径
# export PROJ_PATH=这个jenkins任务在部署机器上的路径

# 输入你的环境上tomcat的全路径
# export TOMCAT_APP_PATH=tomcat在部署机器上的路径

### base 函数
killTomcat()
{
    pid=`ps -ef|grep tomcat|grep java|awk '{print $2}'`
    echo "tomcat Id list :$pid"
    if [ "$pid" = "" ]
    then
      echo "no tomcat pid alive"
      echo "kill tomcat成功"
    else
      kill -9 $pid
    fi
}

#前端文件先注释以下代码start
#cd $PROJ_PATH/order
#mvn clean install

# 停tomcat
killTomcat

# 删除原有工程
#rm -rf $TOMCAT_APP_PATH/webapps/ROOT

rm -rf $TOMCAT_APP_PATH/webapps/foodie-shop
echo "清除tomcat旧工程成功"
#前端文件先注释以下代码end

# 复制新的工程
cp -r $PROJ_PATH/foodie-shop $TOMCAT_APP_PATH/webapps/
echo "拷贝项目到tomcat下成功"+$PROJ_PATH/foodie-shop
#cp $PROJ_PATH/order/foodie-center $TOMCAT_APP_PATH/webapps/ order与项目名对应，jenkins后台会设置项目名

cd $TOMCAT_APP_PATH/webapps/

# 启动Tomcat
cd $TOMCAT_APP_PATH/
echo "tomcat path:"+$TOMCAT_APP_PATH/bin/startup.sh
sh $TOMCAT_APP_PATH/bin/startup.sh
echo "重启tomcat成功"



