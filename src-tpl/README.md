# REPLACE_ARTIFACT_ID

## Intellij Configuration


### Live reload
https://www.romaniancoder.com/spring-boot-live-reload-with-intellij/

* You need to enable the “Make project automatically” option. You can find it in Settings – Build, Execution, Deployment – Compiler
* To open the registry, just press SHIFT+CTRL+A. In the pop-up window, type registry and go to this option. In the registry window, enable the “compiler.automake.allow.when.app.running” check-box.


### Start App
```bash
$ mvn clean spring-boot:run
```

### Configuration

#### Password encryption
https://github.com/ulisesbocchio/jasypt-spring-boot
```bash
$ java -cp ~/.m2/repository/org/jasypt/jasypt/1.9.2/jasypt-1.9.2.jar  org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="contactspassword" password=supersecretz algorithm=PBEWithMD5AndDES
```

```bash
$ java -cp hdf-service-0.0.1-SNAPSHOT.jar  org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="contactspassword" password=supersecretz algorithm=PBEWithMD5AndDES
```
