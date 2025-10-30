package com.thinglinks.business.service.impl;

import java.util.List;
        import com.thinglinks.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinglinks.business.mapper.ThinglinksFunctionRecordMapper;
import com.thinglinks.business.domain.ThinglinksFunctionRecord;
import com.thinglinks.business.service.IThinglinksFunctionRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 指令下发记录Service业务层处理
 *
 * @author ruoyi
 * @date 2025-10-29
 */
@Service
public class ThinglinksFunctionRecordServiceImpl extends ServiceImpl<ThinglinksFunctionRecordMapper, ThinglinksFunctionRecord> implements IThinglinksFunctionRecordService
{
    @Autowired
    private ThinglinksFunctionRecordMapper ThinglinksFunctionRecordMapper;

    /**
     * 查询指令下发记录
     *
     * @param id 指令下发记录主键
     * @return 指令下发记录
     */
    @Override
    public ThinglinksFunctionRecord selectThinglinksFunctionRecordById(String id)
    {
        return ThinglinksFunctionRecordMapper.selectThinglinksFunctionRecordById(id);
    }

    /**
     * 查询指令下发记录列表
     *
     * @param thinglinksFunctionRecord 指令下发记录
     * @return 指令下发记录
     */
    @Override
    public List<ThinglinksFunctionRecord> selectThinglinksFunctionRecordList(ThinglinksFunctionRecord thinglinksFunctionRecord)
    {
        return ThinglinksFunctionRecordMapper.selectThinglinksFunctionRecordList(thinglinksFunctionRecord);
    }

    /**
     * 新增指令下发记录
     *
     * @param thinglinksFunctionRecord 指令下发记录
     * @return 结果
     */
    @Override
    public int insertThinglinksFunctionRecord(ThinglinksFunctionRecord thinglinksFunctionRecord)
    {
        thinglinksFunctionRecord.setCreateTime(DateUtils.getNowDate());
        return ThinglinksFunctionRecordMapper.insertThinglinksFunctionRecord(thinglinksFunctionRecord);
    }

    /**
     * 修改指令下发记录
     *
     * @param thinglinksFunctionRecord 指令下发记录
     * @return 结果
     */
    @Override
    public int updateThinglinksFunctionRecord(ThinglinksFunctionRecord thinglinksFunctionRecord)
    {
        return ThinglinksFunctionRecordMapper.updateThinglinksFunctionRecord(thinglinksFunctionRecord);
    }

    /**
     * 批量删除指令下发记录
     *
     * @param ids 需要删除的指令下发记录主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksFunctionRecordByIds(String[] ids)
    {
        return ThinglinksFunctionRecordMapper.deleteThinglinksFunctionRecordByIds(ids);
    }

    /**
     * 删除指令下发记录信息
     *
     * @param id 指令下发记录主键
     * @return 结果
     */
    @Override
    public int deleteThinglinksFunctionRecordById(String id)
    {
        return ThinglinksFunctionRecordMapper.deleteThinglinksFunctionRecordById(id);
    }
}
