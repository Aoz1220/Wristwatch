package com.hs.service;

import java.util.List;

import com.hs.model.BaseDict;

public interface BaseDictService {

	public List<BaseDict> getBaseDictListByCode(String code);
}
