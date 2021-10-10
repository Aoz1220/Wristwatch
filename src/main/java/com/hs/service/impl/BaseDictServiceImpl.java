package com.hs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hs.mapper.BaseDictMapper;
import com.hs.model.BaseDict;
import com.hs.service.BaseDictService;

@Service
public class BaseDictServiceImpl implements BaseDictService{

	//注入Mapper接口代理对象
	@Autowired
	private BaseDictMapper baseDictMapper;
	
	/**
	 * 查询字典列表
	 */
	@Override
	public List<BaseDict> getBaseDictListByCode(String code) {
		return	baseDictMapper.selectByCode(code);	
	}

}
