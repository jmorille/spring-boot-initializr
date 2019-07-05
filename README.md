Spring boot initializr
======================

## Project create
```
./init.sh oav
```




## Dev configuration V1
```
    <!-- directory package-->
    <profile>
        <id>dev</id>
        <properties>
            <packaging.assembly.app.format>dir</packaging.assembly.app.format>
        </properties>

        <build>
            <plugins>
                <plugin>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-maven-plugin</artifactId>
                    <configuration>
                        <systemPropertyVariables>
                            <MYSQL_DATABASE>appDB</MYSQL_DATABASE>
                        </systemPropertyVariables>
                    </configuration>
                </plugin>
            </plugins>
        </build>
    </profile>
```
