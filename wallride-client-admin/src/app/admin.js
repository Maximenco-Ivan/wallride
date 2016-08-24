import riot from 'riot';
import $ from 'jquery';
import 'bootstrap';
import 'select2';
// import upload from 'jquery-file-upload';
// import froala from 'froala-editor';
import 'nylen/shiftcheckbox';

import 'tags/app.tag!';
import 'tags/login.tag!';
import 'tags/home.tag!';
import 'tags/nav-global.tag!';
import 'tags/nav-blog.tag!';
import 'tags/dashboard.tag!';
import 'tags/article/index.tag!';
import 'tags/page/index.tag!';
import 'tags/category/index.tag!';
import 'tags/tag/index.tag!';
import 'tags/customfield/index.tag!';
import 'tags/comment/index.tag!';
import 'tags/user/index.tag!';
import 'tags/analytics/index.tag!';
import 'tags/system/index.tag!';

import 'tags/post-status-select2.tag!';

import 'wallride/css/admin.css!';

riot.route.base('/_admin/');
riot.mount('app', {title:"Hello, JSPM and Riot!"});
riot.route.start(true);
