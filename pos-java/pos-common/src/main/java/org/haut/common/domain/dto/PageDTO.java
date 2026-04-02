package org.haut.common.domain.dto;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

import java.util.List;
import java.util.function.Function;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
@Schema(description = "分页对象")
public class PageDTO<T> {
    @Schema(description = "当前页码")
    private Long pageNum;

    @Schema(description = "每页大小")
    private Long pageSize;

    @Schema(description = "总记录数")
    private Long total;

    @Schema(description = "总页数")
    private Long totalPage;

    @Schema(description = "当前页数据")
    private List<T> rows;

    /**
     * 创建分页对象
     *
     * @param page 分页对象
     * @param <T>  数据类型
     * @return PageDTO<T>
     */
    public static <T> PageDTO<T> create(IPage<T> page) {
        return new PageDTO<T>()
                .setPageNum(page.getCurrent())
                .setPageSize(page.getSize())
                .setTotalPage(page.getPages())
                .setTotal(page.getTotal())
                .setRows(page.getRecords());
    }

    /**
     * 创建分页对象并映射数据类型
     * @param page
     * @param mapper
     * @return
     * @param <T>
     * @param <D>
     */
    public static <T, D> PageDTO<D> create(IPage<T> page, Function<T, D> mapper) {
        List<D> rows = page.getRecords().stream().map(mapper).toList();
        return new PageDTO<D>()
                .setPageNum(page.getCurrent())
                .setPageSize(page.getSize())
                .setTotalPage(page.getPages())
                .setTotal(page.getTotal())
                .setRows(rows);
    }

    /**
     * 创建分页对象并将数据类型转换为指定的类
     * @param page
     * @param clazz
     * @return
     * @param <T>
     * @param <D>
     */
    public static <T, D> PageDTO<D> create(IPage<T> page, Class<D> clazz) {
        return create(page, t -> BeanUtil.copyProperties(t, clazz));
    }


}
