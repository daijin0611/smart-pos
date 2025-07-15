package org.haut;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("org.haut.server.**.mapper")
public class PosApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(PosApplication.class, args);
    }
}
