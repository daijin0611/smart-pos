# Implementation Plan

- [x] 1. 数据库和实体层变更






  - [x] 1.1 在SysOrg实体中添加printWidth字段






    - 在`pos-server/src/main/java/org/haut/server/system/entity/SysOrg.java`添加`printWidth`字段
    - 类型为Integer，添加注释说明默认值为58
    - _Requirements: 1.3_
  - [x] 1.2 在OrgInfoVO中添加printWidth字段







    - 在`pos-common/src/main/java/org/haut/common/domain/vo/system/OrgInfoVO.java`添加`printWidth`字段
    - 添加@Schema注解描述
    - _Requirements: 1.2_

- [x] 2. DTO和Service层实现





  - [x] 2.1 创建OrgPrintWidthUpdateDTO


    - 在`pos-common/src/main/java/org/haut/common/domain/dto/system/`创建`OrgPrintWidthUpdateDTO.java`
    - 包含id和printWidth字段，添加验证注解
    - _Requirements: 2.1_
  - [x] 2.2 在SysOrgService中添加updatePrintWidth方法


    - 在Service接口中声明方法
    - 在ServiceImpl中实现更新逻辑，包含门店存在性校验
    - _Requirements: 2.1, 2.2_

- [x] 3. Controller层实现





  - [x] 3.1 在SysOrgController中添加update-print-width接口


    - 添加PUT /system/org/update-print-width接口
    - 使用@Validated验证请求参数
    - 添加Swagger注解
    - _Requirements: 2.1, 2.3_

- [x] 4. 数据库变更脚本





  - [x] 4.1 创建SQL变更脚本


    - 在sql目录下添加ALTER TABLE语句
    - 添加print_width列，默认值58
    - _Requirements: 1.1, 1.3_
