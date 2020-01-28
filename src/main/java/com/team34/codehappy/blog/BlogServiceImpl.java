package com.team34.codehappy.blog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("blogService")
public class BlogServiceImpl implements BlogService {

	@Autowired
	BlogDao blogDao;
	
	
}
