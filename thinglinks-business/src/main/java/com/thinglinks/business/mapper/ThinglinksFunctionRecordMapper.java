package com.thinglinks.business.mapper;

import java.util.List;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.thinglinks.business.domain.ThinglinksFunctionRecord;

/**
 * 指令下发记录Mapper接口
 *
 * @author ruoyi
 * @date 2025-10-29
 */
public interface ThinglinksFunctionRecordMapper extends BaseMapper<ThinglinksFunctionRecord>
{
    /**
     * 查询指令下发记录
     *
     * @param id 指令下发记录主键
     * @return 指令下发记录
     */
    public ThinglinksFunctionRecord selectThinglinksFunctionRecordById(String id);

    /**
     * 查询指令下发记录列表
     *
     * @param thinglinksFunctionRecord 指令下发记录
     * @return 指令下发记录集合
     */
    public List<ThinglinksFunctionRecord> selectThinglinksFunctionRecordList(ThinglinksFunctionRecord thinglinksFunctionRecord);

    /**
     * 新增指令下发记录
     *
     * @param thinglinksFunctionRecord 指令下发记录
     * @return 结果
     */
    public int insertThinglinksFunctionRecord(ThinglinksFunctionRecord thinglinksFunctionRecord);

    /**
     * 修改指令下发记录
     *
     * @param thinglinksFunctionRecord 指令下发记录
     * @return 结果
     */
    public int updateThinglinksFunctionRecord(ThinglinksFunctionRecord thinglinksFunctionRecord);

    /**
     * 删除指令下发记录
     *
     * @param id 指令下发记录主键
     * @return 结果
     */
    public int deleteThinglinksFunctionRecordById(String id);

    /**
     * 批量删除指令下发记录
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThinglinksFunctionRecordByIds(String[] ids);
}
