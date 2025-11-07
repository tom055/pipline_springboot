# 使用OpenJDK 8作为基础镜像
FROM openjdk:8

RUN ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime && \
    echo "America/New_York" > /etc/timezone

# 设置工作目录
WORKDIR /opt/app
RUN mkdir -p /opt/app/lib
RUN mkdir -p /opt/app/resources

VOLUME ["/opt/app/resources"]

# 将JAR包添加到容器中
COPY target/lib ./lib/
COPY target/resources ./resources/
COPY target/pipline.jar ./

# 暴露容器的3000端口
EXPOSE 9100

# 容器启动时执行的命令--add-opens java.base/java.lang=ALL-UNNAMED
ENTRYPOINT ["java", "-Xmx2G","-Xms512M", "-jar", "pipline.jar"]