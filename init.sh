#!/bin/bash -e

PROJECT_CODE=${1:-oav}
GROUP_ID=com.agrica.sapp.${PROJECT_CODE}
ARTIFACT_ID=sapp-${PROJECT_CODE}

TARGET_ZIP=${ARTIFACT_ID}-init.zip


PACKAGE_FOLDER=${GROUP_ID//[.]//}

# clean
rm -f ${TARGET_ZIP} 
rm -rf ${ARTIFACT_ID}

# ### ########################### ### #
# ### Download starer             ### #
# ### ########################### ### #

# Spring config
strings=(
    "devtools"
    "web"
    "data-rest"
    "data-jpa"
    "mysql"
    "flyway"
    "actuator"
)

SPRING_BOOT_STYLES=""
for i in "${strings[@]}"; do
    SPRING_BOOT_STYLES="${SPRING_BOOT_STYLES}&style=$i"
done

echo "Spring boot style : ${SPRING_BOOT_STYLES}"

# donwload 
curl "https://start.spring.io/starter.zip?type=maven-project&language=java&bootVersion=2.1.2.RELEASE&baseDir=${ARTIFACT_ID}&groupId=${GROUP_ID}&artifactId=${ARTIFACT_ID}&name=${ARTIFACT_ID}&description=Demo+project+for+Spring+Boot&packageName=${GROUP_ID}&packaging=jar&javaVersion=11&autocomplete=&generate-project=${SPRING_BOOT_STYLES}" -o ${TARGET_ZIP}
# https://start.spring.io/starter.zip?type=maven-project&language=java&bootVersion=2.1.2.RELEASE&baseDir=demo&groupId=com.example&artifactId=demo&name=demo&description=Demo+project+for+Spring+Boot&packageName=com.example.demo&packaging=jar&javaVersion=1.8&autocomplete=&generate-project=&style=devtools&style=web&style=data-rest&style=data-jpa
# unzip
unzip ${TARGET_ZIP}
rm -f ${TARGET_ZIP}

# ### ########################### ### #
# ### Add files                   ### #
# ### ########################### ### #

# add README.md
cp -r src-tpl/README.md ${ARTIFACT_ID}/
cp -r src-tpl/docker-compose.yml ${ARTIFACT_ID}/


# add project config
cp -r src-tpl/main ${ARTIFACT_ID}/src/

# ### ########################### ### #
# ### Change pom.xml              ### #
# ### ########################### ### #

# append profiles to pom.dependencies.xml
sed '/<dependencies>/ r src-tpl/pom.dependencies.xml' -i ${ARTIFACT_ID}/pom.xml
sed '/<properties>/ r src-tpl/pom.properties.xml' -i ${ARTIFACT_ID}/pom.xml
sed '/<description>/ r src-tpl/pom.description.xml' -i ${ARTIFACT_ID}/pom.xml

# append  pom.profiles.xml
POM_LINE_COUNT=$(wc -l ${ARTIFACT_ID}/pom.xml)
line=$(($(wc -l <${ARTIFACT_ID}/pom.xml)-1 ))
sed -e "${line}r src-tpl/pom.profiles.xml" -i ${ARTIFACT_ID}/pom.xml

# ### ########################### ### #
# ### Replace Root Value          ### #
# ### ########################### ### #
# replace GROUP_ID
sed -i "s/REPLACE_GROUP_ID/$GROUP_ID/g" ${ARTIFACT_ID}/*.*
sed -i "s/REPLACE_ARTIFACT_ID/$ARTIFACT_ID/g" ${ARTIFACT_ID}/*.*

# ### ########################### ### #
# ### Change configuration        ### #
# ### ########################### ### #
FOLDER_JAVA_ROOT=${ARTIFACT_ID}/src/main/java/${PACKAGE_FOLDER}

# Add config.yml
sed -i '/@SpringBootApplication/a @EncryptablePropertySources({@EncryptablePropertySource("classpath:config.yml") })' $FOLDER_JAVA_ROOT/*Application.java
sed -i '/@SpringBootApplication/a @EnableEncryptableProperties' $FOLDER_JAVA_ROOT/*Application.java

sed -i '/autoconfigure\.SpringBootApplication/a import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;' $FOLDER_JAVA_ROOT/*Application.java
sed -i '/autoconfigure\.SpringBootApplication/a import com.ulisesbocchio.jasyptspringboot.annotation.EncryptablePropertySource;' $FOLDER_JAVA_ROOT/*Application.java
sed -i '/autoconfigure\.SpringBootApplication/a import com.ulisesbocchio.jasyptspringboot.annotation.EncryptablePropertySources;' $FOLDER_JAVA_ROOT/*Application.java


# Add swagger class
echo "Copy files to $FOLDER_JAVA_ROOT for package $GROUP_ID"
cp  src-tpl/java-tpl/* ${FOLDER_JAVA_ROOT}


# replace GROUP_ID
sed -i "s/GROUP_ID/$GROUP_ID/g" ${FOLDER_JAVA_ROOT}/*.java


# ### ########################### ### #
# ### Add Sample                  ### #
# ### ########################### ### #
cp -r src-tpl/sample-tpl/* ${FOLDER_JAVA_ROOT}
sed -i "s/GROUP_ID/$GROUP_ID/g" ${FOLDER_JAVA_ROOT}/*/*.java


# Maven call
cd ${ARTIFACT_ID}

# ### ########################### ### #
# ### Init Git                    ### #
# ### ########################### ### #
git init
git add .
git commit -am "Init project"

# compute remote url
PROJECT_GIT_REMOTE_URL="git@gitlab-dei:sapp/${ARTIFACT_ID}.git"
echo "Git remote Url $PROJECT_GIT_REMOTE_URL"
git remote add origin $PROJECT_GIT_REMOTE_URL
git remote -v

# ### ########################### ### #
# ### Build                       ### #
# ### ########################### ### #
# mvn package
# cat ${FOLDER_JAVA_ROOT}/SwaggerConfig.java

