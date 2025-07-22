package org.haut;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@MapperScan("org.haut.server.**.mapper")
@EnableTransactionManagement
public class PosApplication
{
    public static void main( String[] args )
    {
        SpringApplication.run(PosApplication.class, args);
    }
}
