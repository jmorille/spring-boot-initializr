# REPLACE_ARTIFACT_ID

## Intellij Configuration


### Live reload
https://www.romaniancoder.com/spring-boot-live-reload-with-intellij/

* You need to enable the “Make project automatically” option. You can find it in Settings – Build, Execution, Deployment – Compiler
* To open the registry, just press SHIFT+CTRL+A. In the pop-up window, type registry and go to this option. In the registry window, enable the “compiler.automake.allow.when.app.running” check-box.

### Config App

Doc Order: https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html

* ```/config``` : https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html#boot-features-external-config-application-property-files

### Start App
```bash
$ mvn clean spring-boot:run
$ mvn spring-boot:run -Dspring-boot.run.profiles=local
```

### Actuator Endpoints
Doc: https://www.baeldung.com/spring-boot-actuators

* ```/auditevents``` – lists security audit-related events such as user login/logout. Also, we can filter by principal or type among others fields
* ```/beans``` – returns all available beans in our BeanFactory. Unlike /auditevents, it doesn’t support filtering
* ```/conditions``` – formerly known as /autoconfig, builds a report of conditions around auto-configuration
* ```/configprops``` – allows us to fetch all @ConfigurationProperties beans
* ```/env``` – returns the current environment properties. Additionally, we can retrieve single properties
* ```/flyway``` – provides details about our Flyway database migrations
* ```/health``` – summarises the health status of our application
* ```/heapdump``` – builds and returns a heap dump from the JVM used by our application
* ```/info``` – returns general information. It might be custom data, build information or details about the latest commit
* ```/liquibase``` – behaves like /flyway but for Liquibase
* ```/logfile``` – returns ordinary application logs
* ```/loggers``` – enables us to query and modify the logging level of our application
* ```/metrics``` – details metrics of our application. This might include generic metrics as well as custom ones
* ```/prometheus``` – returns metrics like the previous one, but formatted to work with a Prometheus server
* ```/scheduledtasks``` – provides details about every scheduled task within our application
* ```/sessions``` – lists HTTP sessions given we are using Spring Session
* ```/shutdown``` – performs a graceful shutdown of the application
* ```/threaddump``` – dumps the thread information of the underlying JVM

### Swagger Endpoints
* http://localhost:8090/swagger-ui.html
* http://localhost:8090/v2/api-docs

### Configuration

#### Password encryption
https://github.com/ulisesbocchio/jasypt-spring-boot
```bash
$ java -cp ~/.m2/repository/org/jasypt/jasypt/1.9.2/jasypt-1.9.2.jar  org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="contactspassword" password=supersecretz algorithm=PBEWithMD5AndDES
```

```bash
$ java -cp hdf-service-0.0.1-SNAPSHOT.jar  org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="contactspassword" password=supersecretz algorithm=PBEWithMD5AndDES
```
