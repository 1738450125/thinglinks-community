package com.thinglinks.business.service;

import java.util.List;
import com.thinglinks.business.domain.ThinglinksFunctionRecord;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 指令下发记录Service接口
 *
 * @author ruoyi
 * @date 2025-10-29
 */
public interface IThinglinksFunctionRecordService extends IService<ThinglinksFunctionRecord>
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
     * @param ThinglinksFunctionRecord 指令下发记录
     * @return 指令下发记录集合
     */
    public List<ThinglinksFunctionRecord> selectThinglinksFunctionRecordList(ThinglinksFunctionRecord ThinglinksFunctionRecord);

    /**
     * 新增指令下发记录
     *
     * @param ThinglinksFunctionRecord 指令下发记录
     * @return 结果
     */
    public int insertThinglinksFunctionRecord(ThinglinksFunctionRecord ThinglinksFunctionRecord);

    /**
     * 修改指令下发记录
     *
     * @param ThinglinksFunctionRecord 指令下发记录
     * @return 结果
     */
    public int updateThinglinksFunctionRecord(ThinglinksFunctionRecord ThinglinksFunctionRecord);

    /**
     * 批量删除指令下发记录
     *
     * @param ids 需要删除的指令下发记录主键集合
     * @return 结果
     */
    public int deleteThinglinksFunctionRecordByIds(String[] ids);

    /**
     * 删除指令下发记录信息
     *
     * @param id 指令下发记录主键
     * @return 结果
     */
    public int deleteThinglinksFunctionRecordById(String id);
}
